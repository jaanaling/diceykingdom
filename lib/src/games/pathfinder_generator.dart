import 'dart:math';
import 'dart:typed_data';
import 'package:dicey_quests/src/core/utils/export_pdf.dart';
import 'package:dicey_quests/src/games/dnd_character.dart';
import 'package:dicey_quests/src/games/dnd_generator.dart';
import 'package:dicey_quests/src/games/field.dart';
import 'package:dicey_quests/src/games/pathfinder_character.dart';
import 'package:uuid/uuid.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PathfinderGenerator {
  void exportCharacter() async {
    DnDCharacter character = DnDGenerator.generateCharacter();
    Uint8List pdfData = await exportToPDF(
      title: 'DnD Character Sheet',
      data: character,
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfData,
    );
  }

  static final List<Field> baseFields = [
    Field(name: 'Name', type: FieldType.text),
    Field(
      name: 'Race',
      type: FieldType.dropdown,
      options: [
        'Human',
        'Elf',
        'Dwarf',
        'Gnome',
        'Halfling',
        'Tiefling',
        'Half-Orc',
        'Half-Elf',
        'Aasimar',
        'Undine'
      ],
    ),
    Field(
      name: 'Class',
      type: FieldType.dropdown,
      options: [
        'Barbarian',
        'Bard',
        'Cleric',
        'Druid',
        'Fighter',
        'Monk',
        'Paladin',
        'Rogue',
        'Sorcerer',
        'Wizard',
        'Ranger',
        'Alchemist',
        'Cavalier',
        'Gunslinger'
      ],
    ),
  ];

  static final List<Field> abilityFields = [
    Field(
      name: 'Strength',
      type: FieldType.number,
      minValue: 1,
      maxValue: 18,
    ),
    Field(
      name: 'Dexterity',
      type: FieldType.number,
      minValue: 1,
      maxValue: 18,
    ),
    Field(
      name: 'Constitution',
      type: FieldType.number,
      minValue: 1,
      maxValue: 18,
    ),
    Field(
      name: 'Intelligence',
      type: FieldType.number,
      minValue: 1,
      maxValue: 18,
    ),
    Field(
      name: 'Wisdom',
      type: FieldType.number,
      minValue: 1,
      maxValue: 18,
    ),
    Field(
      name: 'Charisma',
      type: FieldType.number,
      minValue: 1,
      maxValue: 18,
    ),
  ];

  static final Map<String, Map<String, dynamic>> raceModifiers = {
    'Elf': {
      'Dexterity': 2,
      'Constitution': -2,
      'Intelligence': 2,
    },
    'Dwarf': {
      'Constitution': 2,
      'Charisma': -2,
      'Wisdom': 2,
    },
    'Gnome': {
      'Constitution': 2,
      'Strength': -2,
      'Charisma': 2,
    },
    'Halfling': {
      'Dexterity': 2,
      'Strength': -2,
      'Charisma': 2,
    },
    'Tiefling': {
      'Dexterity': 2,
      'Intelligence': 2,
      'Charisma': -2,
    },
    'Aasimar': {
      'Wisdom': 2,
      'Charisma': 2,
    },
    'Undine': {
      'Dexterity': 2,
      'Wisdom': 2,
      'Strength': -2,
    },
    // Для рас с бонусом +2 к любой характеристике
    // мы добавим логику в методе generateCharacter
  };

  static final Map<String, List<String>> classAbilities = {
    'Wizard': ['Spellcasting', 'Arcane Recovery', 'Familiar'],
    'Fighter': ['Weapon Training', 'Armor Training', 'Bravery'],
    'Rogue': ['Sneak Attack', 'Trapfinding', 'Evasion'],
    'Cleric': ['Channel Energy', 'Domains', 'Spontaneous Casting'],
    'Barbarian': ['Rage', 'Fast Movement', 'Uncanny Dodge'],
    'Druid': ['Wild Shape', 'Nature Bond', 'Animal Companion'],
    'Monk': ['Flurry of Blows', 'Ki Pool', 'Slow Fall'],
    'Paladin': ['Divine Grace', 'Lay on Hands', 'Aura of Courage'],
    'Ranger': ['Favored Enemy', 'Combat Style', 'Hunter\'s Bond'],
    'Bard': ['Bardic Performance', 'Lore Master', 'Versatile Performance'],
    'Sorcerer': ['Bloodline Powers', 'Eschew Materials', 'Cantrips'],
    'Alchemist': ['Alchemy', 'Bombs', 'Mutagen'],
    'Cavalier': ['Mount', 'Order', 'Challenge'],
    'Gunslinger': ['Grit', 'Gunsmithing', 'Deeds'],
  };

  // Метод для динамического отображения полей
  static List<Field> getFieldsToDisplay(Map<String, dynamic> selections) {
    List<Field> fields = List.from(baseFields);

    // Добавляем поля способностей, если выбраны раса и класс
    if (selections.containsKey('Race') && selections.containsKey('Class')) {
      fields.addAll(abilityFields);
    }

    // Добавляем специальные способности класса
    if (selections.containsKey('Class')) {
      String selectedClass = selections['Class'] as String;
      if (classAbilities.containsKey(selectedClass)) {
        fields.add(
          Field(
            name: 'Special Abilities',
            type: FieldType.dropdown,
            options: classAbilities[selectedClass],
          ),
        );
      }
    }

    return fields;
  }

  static PathfinderCharacter generateCharacter() {
    // Генерируем имя
    String name = 'Hero_${Random().nextInt(1000)}';

    // Выбираем расу
    String race = randomChoice(baseFields[1].options!);

    // Выбираем класс
    String characterClass = randomChoice(baseFields[2].options!);

    // Генерируем способности
    Map<String, int> abilities = {};
    for (var abilityField in abilityFields) {
      abilities[abilityField.name] =
          randomValue(abilityField.minValue!, abilityField.maxValue!).round();
    }

    // Применяем расовые модификаторы
    if (raceModifiers.containsKey(race)) {
      var modifiers = raceModifiers[race];
      modifiers!.forEach((ability, modifier) {
        abilities[ability] =
            (abilities[ability]! + (modifier as num)).clamp(1, 18).toInt();
      });
    } else if (race == 'Human' || race == 'Half-Elf' || race == 'Half-Orc') {
      // +2 к любой одной характеристике
      String randomAbility = randomChoice([
        'Strength',
        'Dexterity',
        'Constitution',
        'Intelligence',
        'Wisdom',
        'Charisma'
      ]);
      abilities[randomAbility] =
          (abilities[randomAbility]! + 2).clamp(1, 18).toInt();
    }

    // Добавляем специальные способности класса
    String? specialAbilities;
    if (classAbilities.containsKey(characterClass)) {
      specialAbilities = randomChoice(classAbilities[characterClass]!);
    }

    // Создаем объект персонажа
    PathfinderCharacter character = PathfinderCharacter(
      id: Uuid().v4(),
      name: name,
      race: race,
      characterClass: characterClass,
      strength: abilities['Strength']!,
      dexterity: abilities['Dexterity']!,
      constitution: abilities['Constitution']!,
      intelligence: abilities['Intelligence']!,
      wisdom: abilities['Wisdom']!,
      charisma: abilities['Charisma']!,
      specialAbilities: specialAbilities,
    );

    return character;
  }

  // Метод для заполнения модели из пользовательских данных
  static PathfinderCharacter createCharacterFromData(
      Map<String, dynamic> data) {
    return PathfinderCharacter(
      id: Uuid().v4(),
      name: data['Name'] as String,
      race: data['Race'] as String,
      characterClass: data['Class'] as String,
      strength: data['Strength'] as int,
      dexterity: data['Dexterity'] as int,
      constitution: data['Constitution'] as int,
      intelligence: data['Intelligence'] as int,
      wisdom: data['Wisdom'] as int,
      charisma: data['Charisma'] as int,
      specialAbilities: data['Special Abilities'] as String,
    );
  }
}

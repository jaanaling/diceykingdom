import 'dart:math';
import 'package:dicey_quests/src/games/dnd_character.dart';
import 'package:dicey_quests/src/games/field.dart';
import 'package:uuid/uuid.dart';

class DnDGenerator {
  static final List<Field> baseFields = [
    Field(name: 'Name', type: FieldType.text),
    Field(
      name: 'Race',
      type: FieldType.dropdown,
      options: [
        'Human',
        'Elf',
        'Dwarf',
        'Orc',
        'Dragonborn',
        'Halfling',
        'Tiefling',
        'Gnome',
        'Half-Elf',
        'Half-Orc'
      ],
    ),
    Field(
      name: 'Class',
      type: FieldType.dropdown,
      options: [
        'Fighter',
        'Wizard',
        'Cleric',
        'Rogue',
        'Ranger',
        'Paladin',
        'Warlock',
        'Bard',
        'Monk',
        'Druid',
        'Barbarian'
      ],
    ),
  ];

  static final List<Field> abilityFields = [
    Field(
      name: 'Strength',
      type: FieldType.number,
      minValue: 3,
      maxValue: 18,
    ),
    Field(
      name: 'Dexterity',
      type: FieldType.number,
      minValue: 3,
      maxValue: 18,
    ),
    Field(
      name: 'Constitution',
      type: FieldType.number,
      minValue: 3,
      maxValue: 18,
    ),
    Field(
      name: 'Intelligence',
      type: FieldType.number,
      minValue: 3,
      maxValue: 18,
    ),
    Field(
      name: 'Wisdom',
      type: FieldType.number,
      minValue: 3,
      maxValue: 18,
    ),
    Field(
      name: 'Charisma',
      type: FieldType.number,
      minValue: 3,
      maxValue: 18,
    ),
  ];

  static final Map<String, Map<String, dynamic>> raceModifiers = {
    'Human': {
      'Strength': 1,
      'Dexterity': 1,
      'Constitution': 1,
      'Intelligence': 1,
      'Wisdom': 1,
      'Charisma': 1,
    },
    'Elf': {
      'Dexterity': 2,
    },
    'Dwarf': {
      'Constitution': 2,
    },
    'Halfling': {
      'Dexterity': 2,
    },
    'Dragonborn': {
      'Strength': 2,
      'Charisma': 1,
    },
    'Gnome': {
      'Intelligence': 2,
    },
    'Half-Elf': {
      'Charisma': 2,
      // +1 к двум другим характеристикам
    },
    'Half-Orc': {
      'Strength': 2,
      'Constitution': 1,
    },
    'Tiefling': {
      'Charisma': 2,
      'Intelligence': 1,
    },
    'Orc': {
      'Strength': 2,
      'Constitution': 1,
      'Intelligence': -2,
    },
  };

  static final Map<String, List<String>> classAbilitiesMap = {
    'Wizard': ['Spellcasting', 'Arcane Recovery', 'Spellbook'],
    'Fighter': ['Fighting Style', 'Second Wind', 'Action Surge'],
    'Rogue': ['Sneak Attack', 'Thieves\' Cant', 'Cunning Action'],
    'Cleric': ['Spellcasting', 'Divine Domain', 'Channel Divinity'],
    'Ranger': ['Favored Enemy', 'Natural Explorer', 'Spellcasting'],
    'Paladin': ['Divine Sense', 'Lay on Hands', 'Spellcasting'],
    'Warlock': ['Otherworldly Patron', 'Pact Magic', 'Eldritch Invocations'],
    'Bard': ['Spellcasting', 'Bardic Inspiration', 'Jack of All Trades'],
    'Monk': ['Martial Arts', 'Ki', 'Unarmored Defense'],
    'Druid': ['Spellcasting', 'Wild Shape', 'Druidic'],
    'Barbarian': ['Rage', 'Unarmored Defense', 'Reckless Attack'],
  };

  static final Map<String, List<String>> classWeapons = {
    'Wizard': ['Staff', 'Dagger', 'Wand'],
    'Fighter': ['Sword', 'Axe', 'Bow', 'Shield'],
    'Rogue': ['Dagger', 'Shortsword', 'Bow'],
    'Cleric': ['Mace', 'Warhammer', 'Crossbow', 'Shield'],
    'Ranger': ['Longbow', 'Shortsword', 'Dagger'],
    'Paladin': ['Sword', 'Lance', 'Warhammer', 'Shield'],
    'Warlock': ['Dagger', 'Rod', 'Pact Blade'],
    'Bard': ['Rapier', 'Dagger', 'Lyre'],
    'Monk': ['Quarterstaff', 'Unarmed Strike', 'Dart'],
    'Druid': ['Scimitar', 'Quarterstaff', 'Sling'],
    'Barbarian': ['Great Axe', 'Battleaxe', 'Handaxe'],
  };

  // Метод для динамического отображения полей
  static List<Field> getFieldsToDisplay(Map<String, dynamic> selections) {
    List<Field> fields = List.from(baseFields);

    // Добавляем поля способностей, если выбраны раса и класс
    if (selections.containsKey('Race') && selections.containsKey('Class')) {
      fields.addAll(abilityFields);

      String selectedClass = selections['Class'] as String;

      // Добавляем поле для выбора оружия, если оно доступно для класса
      if (classWeapons.containsKey(selectedClass)) {
        fields.add(
          Field(
            name: 'Weapon',
            type: FieldType.dropdown,
            options: classWeapons[selectedClass],
          ),
        );
      }

      // Добавляем специальные способности класса
      if (classAbilitiesMap.containsKey(selectedClass)) {
        fields.add(
          Field(
            name: 'Class Abilities',
            type: FieldType.dropdown,
            options: classAbilitiesMap[selectedClass],
          ),
        );
      }
    }

    return fields;
  }

  static DnDCharacter generateCharacter() {
    // Генерируем имя
    String name = 'Adventurer_${Random().nextInt(1000)}';

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
            (abilities[ability]! + (modifier as num)).clamp(3, 18).toInt();
      });

      if (race == 'Half-Elf') {
        // +1 к двум другим характеристикам
        List<String> abilitiesList = [
          'Strength',
          'Dexterity',
          'Constitution',
          'Intelligence',
          'Wisdom'
        ];
        abilitiesList.shuffle();
        abilities[abilitiesList[0]] =
            (abilities[abilitiesList[0]]! + 1).clamp(3, 18).toInt();
        abilities[abilitiesList[1]] =
            (abilities[abilitiesList[1]]! + 1).clamp(3, 18).toInt();
      }
    }

    // Выбираем оружие
    String? weapon;
    if (classWeapons.containsKey(characterClass)) {
      weapon = randomChoice(classWeapons[characterClass]!);
    }

    // Выбираем способности класса
    String? classAbilities;
    if (classAbilitiesMap.containsKey(characterClass)) {
      classAbilities = randomChoice(classAbilitiesMap[characterClass]!);
    }

    // Создаем объект персонажа
    DnDCharacter character = DnDCharacter(
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
      weapon: weapon,
      classAbilities: classAbilities,
    );

    return character;
  }

  // Метод для заполнения модели из пользовательских данных
  static DnDCharacter createCharacterFromData(Map<String, dynamic> data) {
    return DnDCharacter(
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
      weapon: data['Weapon'] as String,
      classAbilities: data['Class Abilities'] as String,
    );
  }
}

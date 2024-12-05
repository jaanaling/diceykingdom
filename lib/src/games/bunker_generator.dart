import 'dart:math';
import 'package:dicey_quests/src/games/bunker_player.dart';
import 'package:dicey_quests/src/games/field.dart';
import 'package:uuid/uuid.dart';

class BunkerGenerator {
  static final List<Field> baseFields = [
    Field(name: 'Name', type: FieldType.text),
    Field(
      name: 'Age',
      type: FieldType.number,
      minValue: 18,
      maxValue: 60,
    ),
    Field(
      name: 'Gender',
      type: FieldType.dropdown,
      options: ['Male', 'Female', 'Other'],
    ),
  ];

  static final List<Field> additionalFields = [
    Field(
      name: 'Profession',
      type: FieldType.dropdown,
      options: [
        'Doctor',
        'Engineer',
        'Farmer',
        'Soldier',
        'Chef',
        'Scientist',
        'Artist',
        'Teacher',
        'Athlete',
        'Carpenter',
        'Psychologist',
        'Biologist',
        'Chemist',
        'Pilot'
      ],
    ),
    Field(
      name: 'Health Condition',
      type: FieldType.dropdown,
      options: [
        'Healthy',
        'Blind',
        'Diabetic',
        'Paralyzed',
        'Asthmatic',
        'Cancer Survivor',
        'Allergic',
        'Disabled'
      ],
    ),
    Field(
      name: 'Skill',
      type: FieldType.dropdown,
      options: [
        'First Aid',
        'Cooking',
        'Mechanics',
        'Gardening',
        'Combat',
        'Programming',
        'Negotiation',
        'Leadership',
        'Survival',
        'Medicine'
      ],
    ),
    Field(
      name: 'Item',
      type: FieldType.dropdown,
      options: [
        'Knife',
        'First Aid Kit',
        'Radio',
        'Toolbox',
        'Flashlight',
        'Tent',
        'Compass',
        'Map',
        'Weapon',
        'Food Supplies'
      ],
    ),
    Field(
      name: 'Phobia',
      type: FieldType.dropdown,
      options: [
        'Claustrophobia',
        'Arachnophobia',
        'Acrophobia',
        'Agoraphobia',
        'Nyctophobia',
        'No Phobia'
      ],
    ),
    Field(
      name: 'Hobby',
      type: FieldType.dropdown,
      options: [
        'Music',
        'Reading',
        'Sports',
        'Art',
        'Gaming',
        'Hiking',
        'Photography',
        'Writing'
      ],
    ),
    Field(
      name: 'Unique Trait',
      type: FieldType.text,
    ),
  ];

  // Метод для динамического отображения полей
  static List<Field> getFieldsToDisplay(Map<String, dynamic> selections) {
    List<Field> fields = List.from(baseFields);

    // После ввода базовых данных, добавляем дополнительные поля
    if (selections.containsKey('Name') &&
        selections.containsKey('Age') &&
        selections.containsKey('Gender')) {
      fields.addAll(additionalFields);
    }

    return fields;
  }

  static BunkerPlayer generatePlayer() {
    // Генерируем базовые данные
    String name = 'Survivor_${Random().nextInt(1000)}';
    int age = randomValue(18, 60).round();
    String gender = randomChoice(['Male', 'Female', 'Other']);

    // Генерируем дополнительные данные
    String profession = randomChoice(additionalFields[0].options!);
    String healthCondition = randomChoice(additionalFields[1].options!);
    String skill = randomChoice(additionalFields[2].options!);
    String item = randomChoice(additionalFields[3].options!);
    String phobia = randomChoice(additionalFields[4].options!);
    String hobby = randomChoice(additionalFields[5].options!);
    String uniqueTrait = 'Trait_${Random().nextInt(100)}';

    // Создаем объект игрока
    BunkerPlayer player = BunkerPlayer(
      id: Uuid().v4(),
      name: name,
      age: age,
      gender: gender,
      profession: profession,
      healthCondition: healthCondition,
      skill: skill,
      item: item,
      phobia: phobia,
      hobby: hobby,
      uniqueTrait: uniqueTrait,
    );

    return player;
  }

  // Метод для заполнения модели из пользовательских данных
  static BunkerPlayer createPlayerFromData(Map<String, dynamic> data) {
    return BunkerPlayer(
      id: Uuid().v4(),
      name: data['Name'] as String,
      age: data['Age'] as int,
      gender: data['Gender'] as String,
      profession: data['Profession'] as String,
      healthCondition: data['Health Condition'] as String,
      skill: data['Skill'] as String,
      item: data['Item'] as String,
      phobia: data['Phobia'] as String,
      hobby: data['Hobby'] as String,
      uniqueTrait: data['Unique Trait'] as String,
    );
  }
}

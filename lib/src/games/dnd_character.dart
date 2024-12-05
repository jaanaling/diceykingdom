// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dicey_quests/src/games/player.dart';

class DnDCharacter extends CharacterProfile {
  @override
 String id;
  String name;
  String race;
  String characterClass;
  int strength;
  int dexterity;
  int constitution;
  int intelligence;
  int wisdom;
  int charisma;
  String? weapon;
  String? classAbilities;

  DnDCharacter({
    required this.id,
    required this.name,
    required this.race,
    required this.characterClass,
    required this.strength,
    required this.dexterity,
    required this.constitution,
    required this.intelligence,
    required this.wisdom,
    required this.charisma,
    this.weapon,
    this.classAbilities,
  });

  DnDCharacter copyWith({
    String? id,
    String? name,
    String? race,
    String? characterClass,
    int? strength,
    int? dexterity,
    int? constitution,
    int? intelligence,
    int? wisdom,
    int? charisma,
    String? weapon,
    String? classAbilities,
  }) {
    return DnDCharacter(
      id: id ?? this.id,
      name: name ?? this.name,
      race: race ?? this.race,
      characterClass: characterClass ?? this.characterClass,
      strength: strength ?? this.strength,
      dexterity: dexterity ?? this.dexterity,
      constitution: constitution ?? this.constitution,
      intelligence: intelligence ?? this.intelligence,
      wisdom: wisdom ?? this.wisdom,
      charisma: charisma ?? this.charisma,
      weapon: weapon ?? this.weapon,
      classAbilities: classAbilities ?? this.classAbilities,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'race': race,
      'characterClass': characterClass,
      'strength': strength,
      'dexterity': dexterity,
      'constitution': constitution,
      'intelligence': intelligence,
      'wisdom': wisdom,
      'charisma': charisma,
      'weapon': weapon,
      'classAbilities': classAbilities,
    };
  }

  factory DnDCharacter.fromMap(Map<String, dynamic> map) {
    return DnDCharacter(
      id: map['id'] as String,
      name: map['name'] as String,
      race: map['race'] as String,
      characterClass: map['characterClass'] as String,
      strength: map['strength'] as int,
      dexterity: map['dexterity'] as int,
      constitution: map['constitution'] as int,
      intelligence: map['intelligence'] as int,
      wisdom: map['wisdom'] as int,
      charisma: map['charisma'] as int,
      weapon: map['weapon'] != null ? map['weapon'] as String : null,
      classAbilities: map['classAbilities'] != null ? map['classAbilities'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DnDCharacter.fromJson(String source) => DnDCharacter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DnDCharacter(name: $name, race: $race, characterClass: $characterClass, strength: $strength, dexterity: $dexterity, constitution: $constitution, intelligence: $intelligence, wisdom: $wisdom, charisma: $charisma, weapon: $weapon, classAbilities: $classAbilities)';
  }

  @override
  bool operator ==(covariant DnDCharacter other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.race == race &&
      other.characterClass == characterClass &&
      other.strength == strength &&
      other.dexterity == dexterity &&
      other.constitution == constitution &&
      other.intelligence == intelligence &&
      other.wisdom == wisdom &&
      other.charisma == charisma &&
      other.weapon == weapon &&
      other.classAbilities == classAbilities;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      race.hashCode ^
      characterClass.hashCode ^
      strength.hashCode ^
      dexterity.hashCode ^
      constitution.hashCode ^
      intelligence.hashCode ^
      wisdom.hashCode ^
      charisma.hashCode ^
      weapon.hashCode ^
      classAbilities.hashCode;
  }
}

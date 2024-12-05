// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dicey_quests/src/games/player.dart';

class PathfinderCharacter extends CharacterProfile {
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
  String? specialAbilities;

  PathfinderCharacter({
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
    this.specialAbilities,
  });

  PathfinderCharacter copyWith({
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
    String? specialAbilities,
  }) {
    return PathfinderCharacter(
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
      specialAbilities: specialAbilities ?? this.specialAbilities,
    );
  }

  @override
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
      'specialAbilities': specialAbilities,
    };
  }

  factory PathfinderCharacter.fromMap(Map<String, dynamic> map) {
    return PathfinderCharacter(
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
      specialAbilities: map['specialAbilities'] != null
          ? map['specialAbilities'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PathfinderCharacter.fromJson(String source) =>
      PathfinderCharacter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PathfinderCharacter(name: $name, race: $race, characterClass: $characterClass, strength: $strength, dexterity: $dexterity, constitution: $constitution, intelligence: $intelligence, wisdom: $wisdom, charisma: $charisma, specialAbilities: $specialAbilities)';
  }

  @override
  bool operator ==(covariant PathfinderCharacter other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.race == race &&
        other.characterClass == characterClass &&
        other.strength == strength &&
        other.dexterity == dexterity &&
        other.constitution == constitution &&
        other.intelligence == intelligence &&
        other.wisdom == wisdom &&
        other.charisma == charisma &&
        other.specialAbilities == specialAbilities;
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
        specialAbilities.hashCode;
  }
}

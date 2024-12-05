// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dicey_quests/src/games/player.dart';

class BunkerPlayer extends CharacterProfile {
  @override
  String id;
  String name;
  int age;
  String gender;
  String profession;
  String healthCondition;
  String skill;
  String item;
  String phobia;
  String hobby;
  String uniqueTrait;

  BunkerPlayer({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.profession,
    required this.healthCondition,
    required this.skill,
    required this.item,
    required this.phobia,
    required this.hobby,
    required this.uniqueTrait,
  });

  BunkerPlayer copyWith({
    String? id,
    String? name,
    int? age,
    String? gender,
    String? profession,
    String? healthCondition,
    String? skill,
    String? item,
    String? phobia,
    String? hobby,
    String? uniqueTrait,
  }) {
    return BunkerPlayer(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      profession: profession ?? this.profession,
      healthCondition: healthCondition ?? this.healthCondition,
      skill: skill ?? this.skill,
      item: item ?? this.item,
      phobia: phobia ?? this.phobia,
      hobby: hobby ?? this.hobby,
      uniqueTrait: uniqueTrait ?? this.uniqueTrait,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'profession': profession,
      'healthCondition': healthCondition,
      'skill': skill,
      'item': item,
      'phobia': phobia,
      'hobby': hobby,
      'uniqueTrait': uniqueTrait,
    };
  }

  factory BunkerPlayer.fromMap(Map<String, dynamic> map) {
    return BunkerPlayer(
      id: map['id'] as String,
      name: map['name'] as String,
      age: map['age'] as int,
      gender: map['gender'] as String,
      profession: map['profession'] as String,
      healthCondition: map['healthCondition'] as String,
      skill: map['skill'] as String,
      item: map['item'] as String,
      phobia: map['phobia'] as String,
      hobby: map['hobby'] as String,
      uniqueTrait: map['uniqueTrait'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BunkerPlayer.fromJson(String source) =>
      BunkerPlayer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BunkerPlayer(name: $name, age: $age, gender: $gender, profession: $profession, healthCondition: $healthCondition, skill: $skill, item: $item, phobia: $phobia, hobby: $hobby, uniqueTrait: $uniqueTrait)';
  }

  @override
  bool operator ==(covariant BunkerPlayer other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.age == age &&
        other.gender == gender &&
        other.profession == profession &&
        other.healthCondition == healthCondition &&
        other.skill == skill &&
        other.item == item &&
        other.phobia == phobia &&
        other.hobby == hobby &&
        other.uniqueTrait == uniqueTrait;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        age.hashCode ^
        gender.hashCode ^
        profession.hashCode ^
        healthCondition.hashCode ^
        skill.hashCode ^
        item.hashCode ^
        phobia.hashCode ^
        hobby.hashCode ^
        uniqueTrait.hashCode;
  }
}

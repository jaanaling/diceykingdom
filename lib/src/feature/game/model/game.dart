// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dicey_quests/src/feature/game/model/challenge.dart';

class Game {
  final int id;
  final String name;
  final List<String> genre;
  final String difficulty;
  final String players;
  final String age;
  final String playTime;
  final String description;
  final String image;
  final String rules;
  Challenge challenge;
  bool isCollection;
  bool isFavorite;


  Game({
    required this.id,
    required this.name,
    required this.genre,
    required this.difficulty,
    required this.players,
    required this.age,
    required this.playTime,
    required this.description,
    required this.image,
    required this.rules,
    required this.challenge,
    required this.isCollection,
    required this.isFavorite,
  });

  Game copyWith({
    int? id,
    String? name,
    List<String>? genre,
    String? difficulty,
    String? players,
    String? age,
    String? playTime,
    String? description,
    String? image,
    String? rules,
    Challenge? challenge,
    bool? isCollection,
    bool? isFavorite,
  }) {
    return Game(
      id: id ?? this.id,
      name: name ?? this.name,
      genre: genre ?? this.genre,
      difficulty: difficulty ?? this.difficulty,
      players: players ?? this.players,
      age: age ?? this.age,
      playTime: playTime ?? this.playTime,
      description: description ?? this.description,
      image: image ?? this.image,
      rules: rules ?? this.rules,
      challenge: challenge ?? this.challenge,
      isCollection: isCollection ?? this.isCollection,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'genre': genre,
      'difficulty': difficulty,
      'players': players,
      'age': age,
      'playTime': playTime,
      'description': description,
      'image': image,
      'rules': rules,
      'challenge': challenge.toMap(),
      'isCollection': isCollection,
      'isFavorite': isFavorite,
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      id: map['id'] as int,
      name: map['name'] as String,
      genre: List<String>.from(map['genre'] as List<dynamic>),
      difficulty: map['difficulty'] as String,
      players: map['players'] as String,
      age: map['age'] as String,
      playTime: map['playTime'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      rules: map['rules'] as String,
      isCollection: map['isCollection'] != null
          ? map['isCollection'] as bool
          : false,
      isFavorite: map['isFavorite'] != null
          ? map['isFavorite'] as bool 
          : false,
      challenge: Challenge.fromMap(map['challenge'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Game.fromJson(String source) =>
      Game.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Game(id: $id, name: $name, genre: $genre, difficulty: $difficulty, players: $players, age: $age, playTime: $playTime, description: $description, image: $image, rules: $rules, challenge: $challenge)';
  }

  @override
  bool operator ==(covariant Game other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.genre, genre) &&
        other.difficulty == difficulty &&
        other.players == players &&
        other.age == age &&
        other.playTime == playTime &&
        other.description == description &&
        other.image == image &&
        other.rules == rules &&
        other.isCollection == isCollection &&
        other.isFavorite == isFavorite &&
        other.challenge == challenge;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        genre.hashCode ^
        difficulty.hashCode ^
        players.hashCode ^
        age.hashCode ^
        playTime.hashCode ^
        description.hashCode ^
        image.hashCode ^
        
        rules.hashCode ^
        challenge.hashCode;
  }
}

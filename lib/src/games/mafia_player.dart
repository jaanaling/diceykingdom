// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dicey_quests/src/games/player.dart';

class Mafias extends CharacterProfile {
  @override
  String id;
  List<MafiaPlayer> players;

  Mafias({
    required this.id,
    required this.players,
  });

  Mafias copyWith({
    String? id,
    List<MafiaPlayer>? players,
  }) {
    return Mafias(
      id: id ?? this.id,
      players: players ?? this.players,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'players': players.map((x) => x.toMap()).toList(),
    };
  }

  factory Mafias.fromMap(Map<String, dynamic> map) {
    return Mafias(
      id: map['id'] as String,
      players: List<MafiaPlayer>.from((map['players'] as List<int>).map<MafiaPlayer>((x) => MafiaPlayer.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Mafias.fromJson(String source) => Mafias.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Mafias(id: $id, players: $players)';

  @override
  bool operator ==(covariant Mafias other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      listEquals(other.players, players);
  }

  @override
  int get hashCode => id.hashCode ^ players.hashCode;
}

class MafiaPlayer  {

  String playerName;
  String role;
  String description;

  MafiaPlayer({

    required this.playerName,
    required this.role,
    required this.description,
  });

  MafiaPlayer copyWith({
    String? playerName,
    String? role,
    String? description,
    String? id,
  }) {
    return MafiaPlayer(

      playerName: playerName ?? this.playerName,
      role: role ?? this.role,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
    
      'playerName': playerName,
      'role': role,
      'description': description,
    };
  }

  factory MafiaPlayer.fromMap(Map<String, dynamic> map) {
    return MafiaPlayer(
     
      playerName: map['playerName'] as String,
      role: map['role'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MafiaPlayer.fromJson(String source) =>
      MafiaPlayer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MafiaPlayer(playerName: $playerName, role: $role, description: $description)';

  @override
  bool operator ==(covariant MafiaPlayer other) {
    if (identical(this, other)) return true;

    return other.playerName == playerName &&
        other.role == role &&
        other.description == description;
  }

  @override
  int get hashCode =>
      playerName.hashCode ^ role.hashCode ^ description.hashCode;
}

import 'package:dicey_quests/src/games/bunker_player.dart';
import 'package:dicey_quests/src/games/dnd_character.dart';
import 'package:dicey_quests/src/games/mafia_player.dart';
import 'package:dicey_quests/src/games/pathfinder_character.dart';

abstract class CharacterProfile {
  String get id; // Уникальный идентификатор
  Map<String, dynamic> toMap();

  // Статический метод для создания объекта из Map
  static CharacterProfile fromMap(Map<String, dynamic> map) {
    switch (map['type']) {
      case 'PathfinderCharacter':
        return PathfinderCharacter.fromMap(map);
      case 'MafiaPlayer':
        return Mafias.fromMap(map);
      case 'DnDCharacter':
        return DnDCharacter.fromMap(map);
      case 'BunkerPlayer':
        return BunkerPlayer.fromMap(map);
      default:
        throw Exception('Unknown character type');
    }
  }
}

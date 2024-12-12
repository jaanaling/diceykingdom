import 'dart:math';

import 'package:dicey_quests/src/games/mafia_player.dart';
import 'package:uuid/uuid.dart';

class MafiaGenerator {
  static final List<String> roles = [
    'Mafia',
    'Civilian',
    'Detective',
    'Doctor',
    'Bodyguard',
    'Spy',
    'Maniac',
    'Journalist',
    'Lawyer',
    'Don',
    'Sheriff'
  ];

  static final Map<String, String> roleDescriptions = {
    'Mafia': 'Works in the mafia team, eliminating players at night.',
    'Detective': 'Can check the role of one player every night.',
    'Civilian': 'A regular citizen of the city, with no special abilities.',
    'Doctor': 'Can heal one player every night.',
    'Bodyguard': 'Protects the selected player from attacks.',
    'Spy': 'Can listen in on mafia conversations.',
    'Maniac': 'A lone killer, kills players at night.',
    'Journalist': 'Gathers information and can reveal the role of a player publicly.',
    'Lawyer': 'Can protect the mafia in a vote, changing the opinions of others.',
    'Don':
    'The head of the mafia, can check the role of one player for mafia affiliation.',
    'Sheriff': 'Can arrest players, blocking their actions.'
  };

  static Mafias generateRoles(int playerCount) {
    Mafias mafias;
    List<Map<String, dynamic>> players = [];
    List<String> availableRoles = List.from(roles);

    // Определяем количество мафии в зависимости от количества игроков
    int mafiaCount = (playerCount / 3).floor();
    int specialRolesCount = min(5, playerCount - mafiaCount - 2);
    int civilianCount = playerCount - mafiaCount - specialRolesCount;

    // Добавляем роли мафии
    for (int i = 0; i < mafiaCount; i++) {
      players.add({
        'Player Name': 'Player_${i + 1}',
        'Role': 'Mafia',
        'Description': roleDescriptions['Mafia']
      });
    }

    // Добавляем специальные роли
    List<String> specialRoles = [
      'Detective',
      'Doctor',
      'Bodyguard',
      'Spy',
      'Maniac',
      'Journalist',
      'Lawyer',
      'Don',
      'Sheriff'
    ];
    specialRoles.shuffle();

    for (int i = 0; i < specialRolesCount; i++) {
      String role = specialRoles[i];
      players.add({
        'Player Name': 'Player_${mafiaCount + i + 1}',
        'Role': role,
        'Description': roleDescriptions[role]
      });
    }

    // Добавляем мирных жителей
    for (int i = 0; i < civilianCount; i++) {
      players.add({
        'Player Name': 'Player_${mafiaCount + specialRolesCount + i + 1}',
        'Role': 'Civilian',
        'Description': roleDescriptions['Civilian']
      });
    }

    // Перемешиваем список игроков
    players.shuffle();

    List<MafiaPlayer> mafiaPlayers = players
        .map((player) => MafiaPlayer(
              playerName: player['Player Name'] as String,
              role: player['Role'] as String,
              description: player['Description'] as String,
            ))
        .toList();

    mafias = Mafias(id: Uuid().v4(), players: mafiaPlayers);

    return mafias;
  }
}

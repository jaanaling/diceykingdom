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
    'Mafia': 'Работает в команде мафии, устраняя игроков ночью.',
    'Detective': 'Может проверять роль одного игрока каждую ночь.',
    'Civilian': 'Обычный житель города, без особых способностей.',
    'Doctor': 'Может лечить одного игрока каждую ночь.',
    'Bodyguard': 'Защищает выбранного игрока от нападений.',
    'Spy': 'Может прослушивать разговоры мафии.',
    'Maniac': 'Одинокий убийца, убивает игроков ночью.',
    'Journalist': 'Собирает информацию и может раскрыть роль игрока публично.',
    'Lawyer': 'Может защищать мафию на голосовании, изменяя мнение других.',
    'Don':
        'Глава мафии, может проверять роль одного игрока на принадлежность к мафии.',
    'Sheriff': 'Может арестовывать игроков, блокируя их действия.'
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

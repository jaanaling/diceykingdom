import 'package:dicey_quests/src/core/utils/json_loader.dart';
import 'package:dicey_quests/src/feature/game/model/game.dart';

class GameRepository {
  final String key = 'game';

  Future<List<Game>> load() {
    return JsonLoader.loadData<Game>(
      key,
      'assets/json/$key.json',
      (json) => Game.fromMap(json),
    );
  }

  Future<void> update(Game updated) async {
    return JsonLoader.modifyDataList<Game>(
      key,
      updated,
      () async => await load(),
      (item) => item.toMap(),
      (itemList) async {
        final index = itemList.indexWhere((d) => d.id == updated.id);
        if (index != -1) {
          itemList[index] = updated;
        }
      },
    );
  }

  Future<void> save(Game item) {
    return JsonLoader.saveData<Game>(
      key,
      item,
      () async => await load(),
      (item) => item.copyWith().toMap(),
    );
  }

  Future<void> remove(Game item) {
    return JsonLoader.removeData<Game>(
      key,
      item,
      () async => await load(),
      (item) => item.toMap(),
    );
  }

  Future<Game?> getById(int id) async {
    final games = await load();
    return games.firstWhere(
      (game) => game.id == id,
    );
  }

  // Добавляем метод saveAll
  Future<void> saveAll(List<Game> games) {
    return JsonLoader.saveAllData<Game>(
      key,
      games,
      (item) => item.toMap(),
    );
  }
}

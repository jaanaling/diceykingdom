import 'package:dicey_quests/src/core/utils/json_loader.dart';
import 'package:dicey_quests/src/feature/game/model/user.dart';

class UserRepository {
  final String key = 'user';

  Future<List<User>> load() {
    return JsonLoader.loadData<User>(
      key,
      'assets/json/$key.json',
      (json) => User.fromMap(json),
    );
  }

  Future<void> update(User updated) async {
    return JsonLoader.modifyDataList<User>(
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

  Future<void> save(User item) {
    return JsonLoader.saveData<User>(
      key,
      item,
      () async => await load(),
      (item) => item.copyWith().toMap(),
    );
  }

  Future<void> remove(User item) {
    return JsonLoader.removeData<User>(
      key,
      item,
      () async => await load(),
      (item) => item.toMap(),
    );
  }
}

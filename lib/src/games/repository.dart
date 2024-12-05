import 'package:dicey_quests/src/core/utils/json_loader.dart';
import 'package:dicey_quests/src/games/player.dart';

class CharacterProfileRepository {
  final String key = 'characterProfiles';

  Future<List<CharacterProfile>> load() async {
    return JsonLoader.loadData<CharacterProfile>(
      key,
      'assets/json/$key.json', // Путь к файлу может быть условным, если данные сохраняются только в памяти
      (json) => CharacterProfile.fromMap(json),
    );
  }

  Future<void> save(CharacterProfile profile) async {
    await JsonLoader.saveData<CharacterProfile>(
      key,
      profile,
      () async => await load(),
      (profile) => profile.toMap(),
    );
  }

  Future<void> remove(CharacterProfile profile) async {
    await JsonLoader.removeData<CharacterProfile>(
      key,
      profile,
      () async => await load(),
      (profile) => profile.toMap(),
    );
  }

  Future<void> update(CharacterProfile updatedProfile) async {
    await JsonLoader.modifyDataList<CharacterProfile>(
      key,
      updatedProfile,
      () async => await load(),
      (profile) => profile.toMap(),
      (profiles) async {
        final index = profiles.indexWhere((p) => p.id == updatedProfile.id);
        if (index != -1) {
          profiles[index] = updatedProfile;
        }
      },
    );
  }
}

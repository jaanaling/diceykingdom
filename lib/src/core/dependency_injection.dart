import 'package:dicey_quests/src/feature/game/repository/repository.dart';
import 'package:dicey_quests/src/games/repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupDependencyInjection() {
  locator.registerLazySingleton(() => GameRepository());
  locator.registerLazySingleton(() => CharacterProfileRepository());
}

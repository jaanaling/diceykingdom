import 'package:get_it/get_it.dart';
import 'package:pond_care/src/feature/pond/repository/repository.dart';

final locator = GetIt.instance;

void setupDependencyInjection() {
  locator.registerLazySingleton(() => PondRepository());
}

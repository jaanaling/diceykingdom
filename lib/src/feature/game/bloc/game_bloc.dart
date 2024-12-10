import 'package:bloc/bloc.dart';
import 'package:dicey_quests/src/core/dependency_injection.dart';
import 'package:dicey_quests/src/core/utils/log.dart';
import 'package:dicey_quests/src/feature/game/model/challenge.dart';
import 'package:dicey_quests/src/feature/game/model/game.dart';
import 'package:dicey_quests/src/feature/game/model/user.dart';
import 'package:dicey_quests/src/feature/game/repository/repository.dart';
import 'package:dicey_quests/src/feature/game/repository/user_repository.dart';
import 'package:dicey_quests/src/games/player.dart';
import 'package:dicey_quests/src/games/repository.dart';
import 'package:equatable/equatable.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository _repository = locator<GameRepository>();
  final CharacterProfileRepository _repositoryProfile =
      locator<CharacterProfileRepository>();
  final UserRepository _repositoryUser = locator<UserRepository>();

  GameBloc() : super(GameInitial()) {
    on<LoadGame>(_onLoadGames);
    on<UpdateGame>(_onUpdateGame);
    on<SaveGame>(_onSaveGame);
    on<UpdateProfile>(_onUpdateProfile);
    on<SaveProfile>(_onSaveProfile);
    on<RemoveProfile>(_onRemoveProfile);
    on<UpdateUser>(_onUpdateUser);
    on<SaveUser>(_onSaveUser);
    on<RemoveUser>(_onRemoveUser);
  }

  Future<void> _onLoadGames(
    LoadGame event,
    Emitter<GameState> emit,
  ) async {
    emit(GameLoading());
    try {
      final games = await _repository.load();
      final characterProfiles = await _repositoryProfile.load();
      final users = await _repositoryUser.load();

      // Разблокируем первый уровень при первой загрузке
      bool updated = unlockFirstLevel(games);

      // Если игры были обновлены, сохраняем изменения
      if (updated) {
        await _repository.saveAll(games);
      }

      emit(
        GameLoaded(
          users,
          games,
          games.fold(
            0,
            (sum, el) =>
                sum +
                (el.challenge.status == ChallengeStatus.finish
                    ? el.challenge.difficulty
                    : 0),
          ),
          characterProfiles,
        ),
      );
    } catch (e) {
      logger.e(e);
      emit(const GameError('Failed to load game'));
    }
  }

  bool unlockFirstLevel(List<Game> games) {
    bool updated = false;
    for (int i = 0; i < games.length; i++) {
      if (games[i].challenge.difficulty == 1 &&
          games[i].challenge.status == ChallengeStatus.lock) {
        games[i] = games[i].copyWith(
          challenge:
              games[i].challenge.copyWith(status: ChallengeStatus.unlock),
        );
        updated = true;
      }
    }
    return updated;
  }

  Future<void> _onUpdateGame(
    UpdateGame event,
    Emitter<GameState> emit,
  ) async {
    try {
      // Получаем предыдущую версию игры по ID
      final oldGame = await _repository.getById(event.game.id);

      // Обновляем игру в репозитории
      await _repository.update(event.game);

      // Проверяем, изменился ли статус челленджа
      if (oldGame?.challenge.status != event.game.challenge.status) {
        // Загружаем все игры
        final games = await _repository.load();

        // Проверяем и разблокируем уровни
        bool updated = checkAndUnlockLevels(games);

        // Сохраняем изменения, если они есть
        if (updated) {
          await _repository.saveAll(games);
        }
      }

      // Перезагружаем состояние
      add(LoadGame());
    } catch (e) {
      emit(const GameError('Failed to update game'));
    }
  }

  bool checkAndUnlockLevels(List<Game> games) {
    bool updated = false;
    // Находим максимальный уровень сложности
    int maxDifficulty = games
        .map((g) => g.challenge.difficulty)
        .reduce((a, b) => a > b ? a : b);

    for (int currentDifficulty = 1;
        currentDifficulty < maxDifficulty;
        currentDifficulty++) {
      // Фильтруем игры текущей сложности
      List<Game> currentGames = games
          .where((g) => g.challenge.difficulty == currentDifficulty)
          .toList();

      // Общее количество челленджей на текущем уровне сложности
      int totalChallenges = currentGames.length;

      // Количество завершенных челленджей
      int completedChallenges = currentGames
          .where((g) => g.challenge.status == ChallengeStatus.finish)
          .length;

      // Проверяем, завершена ли половина челленджей
      if (completedChallenges >= (totalChallenges / 2).ceil()) {
        int nextDifficulty = currentDifficulty + 1;

        // Разблокируем челленджи следующего уровня сложности
        for (int i = 0; i < games.length; i++) {
          if (games[i].challenge.difficulty == nextDifficulty &&
              games[i].challenge.status == ChallengeStatus.lock) {
            games[i] = games[i].copyWith(
              challenge:
                  games[i].challenge.copyWith(status: ChallengeStatus.unlock),
            );
            updated = true;
          }
        }
      }
    }

    return updated;
  }

  Future<void> _onSaveGame(
    SaveGame event,
    Emitter<GameState> emit,
  ) async {
    try {
      logger.d(event);
      await _repository.save(event.game);

      add(LoadGame());
    } catch (e) {
      logger.e(e);
      emit(const GameError('Failed to save game'));
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<GameState> emit,
  ) async {
    try {
      await _repositoryProfile.update(event.profile);
      add(LoadGame());
    } catch (e) {
      emit(const GameError('Failed to update game'));
    }
  }

  Future<void> _onSaveProfile(
    SaveProfile event,
    Emitter<GameState> emit,
  ) async {
    try {
      logger.d(event);
      await _repositoryProfile.save(event.profile);

      add(LoadGame());
    } catch (e) {
      logger.e(e);
      emit(const GameError('Failed to save game'));
    }
  }

  Future<void> _onRemoveProfile(
    RemoveProfile event,
    Emitter<GameState> emit,
  ) async {
    try {
      await _repositoryProfile.remove(event.profile);
      add(LoadGame());
    } catch (e) {
      logger.e(e);
      emit(const GameError('Failed to remove transaction'));
    }
  }

  Future<void> _onUpdateUser(
    UpdateUser event,
    Emitter<GameState> emit,
  ) async {
    try {
      await _repositoryUser.update(event.user);
      add(LoadGame());
    } catch (e) {
      emit(const GameError('Failed to update game'));
    }
  }

  Future<void> _onSaveUser(
    SaveUser event,
    Emitter<GameState> emit,
  ) async {
    try {
      logger.d(event);
      await _repositoryUser.save(event.user);

      add(LoadGame());
    } catch (e) {
      logger.e(e);
      emit(const GameError('Failed to save game'));
    }
  }

  Future<void> _onRemoveUser(
    RemoveUser event,
    Emitter<GameState> emit,
  ) async {
    try {
      await _repositoryUser.remove(event.user);
      add(LoadGame());
    } catch (e) {
      logger.e(e);
      emit(const GameError('Failed to remove transaction'));
    }
  }
}

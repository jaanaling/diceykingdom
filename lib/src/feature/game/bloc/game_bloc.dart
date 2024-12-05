import 'package:bloc/bloc.dart';
import 'package:dicey_quests/src/core/dependency_injection.dart';
import 'package:dicey_quests/src/core/utils/log.dart';
import 'package:dicey_quests/src/feature/game/model/challenge.dart';
import 'package:dicey_quests/src/feature/game/model/game.dart';
import 'package:dicey_quests/src/feature/game/repository/repository.dart';
import 'package:dicey_quests/src/games/player.dart';
import 'package:dicey_quests/src/games/repository.dart';
import 'package:equatable/equatable.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository _repository = locator<GameRepository>();
  final CharacterProfileRepository _repositoryProfile =
      locator<CharacterProfileRepository>();

  GameBloc() : super(GameInitial()) {
    on<LoadGame>(_onLoadGames);
    on<UpdateGame>(_onUpdateGame);
    on<SaveGame>(_onSaveGame);
    on<UpdateProfile>(_onUpdateProfile);
    on<SaveProfile>(_onSaveProfile);
    on<RemoveProfile>(_onRemoveProfile);
  }

  Future<void> _onLoadGames(
    LoadGame event,
    Emitter<GameState> emit,
  ) async {
    emit(GameLoading());
    try {
      final games = await _repository.load();
      final characterProfiles = await _repositoryProfile.load();

      emit(
        GameLoaded(
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

  Future<void> _onUpdateGame(
    UpdateGame event,
    Emitter<GameState> emit,
  ) async {
    try {
      await _repository.update(event.game);
      add(LoadGame());
    } catch (e) {
      emit(const GameError('Failed to update game'));
    }
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
}

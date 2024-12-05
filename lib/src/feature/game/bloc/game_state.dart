part of 'game_bloc.dart';

sealed class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

final class GameInitial extends GameState {}

class GameLoaded extends GameState {
  final List<Game> game;
  final List<CharacterProfile> characterProfiles;
  final int score;

  const GameLoaded(
    this.game,
    this.score,
    this.characterProfiles,
  );

  @override
  List<Object> get props => [
        game,
        score,
        characterProfiles,
      ];
}

class GameLoading extends GameState {}

class GameError extends GameState {
  final String message;

  const GameError(this.message);

  @override
  List<Object> get props => [message];
}

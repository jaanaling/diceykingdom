part of 'game_bloc.dart';

sealed class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class LoadGame extends GameEvent {}

class UpdateGame extends GameEvent {
  final Game game;

  const UpdateGame(this.game);

  @override
  List<Object> get props => [game];
}

class SaveGame extends GameEvent {
  final Game game;

  const SaveGame(this.game);

  @override
  List<Object> get props => [game];
}

class UpdateProfile extends GameEvent {
  final CharacterProfile profile;

  const UpdateProfile(this.profile);

  @override
  List<Object> get props => [profile];
}

class SaveProfile extends GameEvent {
  final CharacterProfile profile;

  const SaveProfile(this.profile);

  @override
  List<Object> get props => [profile];
}

class RemoveProfile extends GameEvent {
  final CharacterProfile profile;

  const RemoveProfile(this.profile);

  @override
  List<Object> get props => [profile];
}


class UpdateUser extends GameEvent {
  final User user;

  const UpdateUser(this.user);

  @override
  List<Object> get props => [user];
}

class SaveUser extends GameEvent {
  final User user;

  const SaveUser(this.user);

  @override
  List<Object> get props => [user];
}

class RemoveUser extends GameEvent {
  final User user;

  const RemoveUser(this.user);

  @override
  List<Object> get props => [user];
}

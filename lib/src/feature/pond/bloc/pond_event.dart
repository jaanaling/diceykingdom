part of 'pond_bloc.dart';

sealed class PondEvent extends Equatable {
  const PondEvent();

  @override
  List<Object> get props => [];
}

class LoadPond extends PondEvent {}

class UpdatePond extends PondEvent {
  final Pond pond;

  const UpdatePond(this.pond);

  @override
  List<Object> get props => [pond];
}

class SavePond extends PondEvent {
  final Pond pond;

  const SavePond(this.pond);

  @override
  List<Object> get props => [pond];
}

class RemovePond extends PondEvent {
  final Pond pond;

  const RemovePond(this.pond);

  @override
  List<Object> get props => [pond];
}

class UpdateTasks extends PondEvent {
  final Pond pond;
  final Task tasks;

  const UpdateTasks(this.tasks, this.pond);

  @override
  List<Object> get props => [tasks, pond];
}

class SaveTasks extends PondEvent {
  final Pond pond;
  final Task tasks;

  const SaveTasks(this.tasks, this.pond);

  @override
  List<Object> get props => [tasks, pond];
}

class RemoveTasks extends PondEvent {
  final Pond pond;
  final Task tasks;

  const RemoveTasks(this.tasks, this.pond);

  @override
  List<Object> get props => [tasks, pond];
}

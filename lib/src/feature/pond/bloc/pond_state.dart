part of 'pond_bloc.dart';

sealed class PondState extends Equatable {
  const PondState();
  
  @override
  List<Object> get props => [];
}

final class PondInitial extends PondState {}

class PondLoaded extends PondState {
  final List<Pond> pond;
  final List<Fish> fish;
  final List<Plant> plants;
  final List<Decorations> decorations;
  final List<Task> history;


  const PondLoaded(this.pond, this.fish, this.plants , this.decorations, this.history );

  @override
  List<Object> get props => [pond, fish, plants, decorations, history];
}

class PondLoading extends PondState {}

class PondError extends PondState {
  final String message;

  const PondError(this.message);

  @override
  List<Object> get props => [message];
}
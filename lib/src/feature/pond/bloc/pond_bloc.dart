import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pond_care/src/core/dependency_injection.dart';
import 'package:pond_care/src/core/utils/log.dart';
import 'package:pond_care/src/feature/pond/models/decoration.dart';
import 'package:pond_care/src/feature/pond/models/fish.dart';
import 'package:pond_care/src/feature/pond/models/plant.dart';
import 'package:pond_care/src/feature/pond/models/pond.dart';
import 'package:pond_care/src/feature/pond/models/task.dart';
import 'package:pond_care/src/feature/pond/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pond_event.dart';
part 'pond_state.dart';

class PondBloc extends Bloc<PondEvent, PondState> {
  final PondRepository _repository = locator<PondRepository>();

  PondBloc() : super(PondInitial()) {
    on<LoadPond>(_onLoadPonds);
    on<UpdatePond>(_onUpdatePond);
    on<SavePond>(_onSavePond);
    on<RemovePond>(_onRemovePond);
    on<UpdateTasks>(_onUpdateTasks);
    on<RemoveTasks>(_onRemoveTasks);
  }

  Future<void> _onLoadPonds(
    LoadPond event,
    Emitter<PondState> emit,
  ) async {
    emit(PondLoading());
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final pond = await _repository.load();

      final fish = await _repository.loadFish();

      final plants = await _repository.loadPlants();
 
      final decorations = await _repository.loadDecorations();

      final history = pref
              .getStringList('history')
              ?.map((e) => Task.fromMap(Task.fromJson(e).toMap()))
              .toList() ??
          [];

      emit(PondLoaded(pond, fish, plants, decorations, history));
    } catch (e) {
      logger.e(e);
      emit(const PondError('Failed to load pond'));
    }
  }

  Future<void> _onUpdatePond(
    UpdatePond event,
    Emitter<PondState> emit,
  ) async {
    try {
      await _repository.update(event.pond);
      add(LoadPond());
    } catch (e) {
      emit(const PondError('Failed to update pond'));
    }
  }

  Future<void> _onSavePond(
    SavePond event,
    Emitter<PondState> emit,
  ) async {
    try {
      final tasks = await _repository.loadTasks();
      logger.d(tasks);
      final pond = event.pond.copyWith(
        tasks: tasks
            .map(
              (e) => e.copyWith(
                pondId: event.pond.name,
                dueDate: DateTime.now().add(Duration(days: e.periodicityDays)),
              ),
            )
            .toList(),
      );
      logger.d(pond);
      await _repository.save(pond);

      add(LoadPond());
    } catch (e) {
      logger.e(e);
      emit(const PondError('Failed to save pond'));
    }
  }

  Future<void> _onRemovePond(
    RemovePond event,
    Emitter<PondState> emit,
  ) async {
    try {
      await _repository.remove(event.pond);
      add(LoadPond());
    } catch (e) {
      logger.e(e);
      emit(const PondError('Failed to remove transaction'));
    }
  }

  Future<void> _onUpdateTasks(
    UpdateTasks event,
    Emitter<PondState> emit,
  ) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final history = (pref.getStringList('history') ?? [])
        ..removeWhere((test) => test == event.tasks.toJson())
        ..add(event.tasks
            .copyWith(
              id: DateTime.now().microsecondsSinceEpoch.toString(),
              finishDate: DateTime.now(),
            )
            .toJson());

      pref.setStringList('history', history);

      event.tasks.markAsCompleted();
      Pond updatedPond;
      if (event.tasks.isPeriodic) {
        updatedPond = event.pond.copyWith(
          tasks: [
            ...event.pond.tasks!.where((task) => task.id != event.tasks.id),
            event.tasks,
          ],
        );
      } else {
        updatedPond = event.pond.copyWith(
          tasks: [
            ...event.pond.tasks!.where((task) => task.id != event.tasks.id),
          ],
        );
      }

      await _repository.update(updatedPond);
      add(LoadPond());
    } catch (e) {
      emit(const PondError('Failed to update tasks'));
    }
  }

  Future<void> _onRemoveTasks(
    RemoveTasks event,
    Emitter<PondState> emit,
  ) async {
    try {
      final updatedPond = event.pond.copyWith(
        tasks: event.pond.tasks!
            .where((task) => task.id != event.tasks.id)
            .toList(),
      );
      await _repository.update(updatedPond);
      add(LoadPond());
    } catch (e) {
      emit(const PondError('Failed to remove tasks'));
    }
  }
}

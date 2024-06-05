import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/domain/entities/task.dart';
import 'package:flutter_application_1/domain/usecases/edit_task.dart';
import 'package:flutter_application_1/domain/usecases/get_task.dart';
import 'package:flutter_application_1/presentation/states/task/list/bloc.dart';
import 'state.dart';

class TaskEditBloc extends Cubit<TaskEditState> {
  final EditTaskUseCase _editTaskUseCase;
  final GetTaskUseCase _getTaskUseCase;
    final TaskListBloc _taskListBloc;

  TaskEditBloc(
    this._editTaskUseCase,
    this._getTaskUseCase,
        this._taskListBloc,
  ) : super(const Input());

  Future<bool> editTask(String taskId, String name, String description) async {
    try {
      emit(const Input());

      final TaskEntity task = await _getTaskUseCase.getTask(taskId);

      await _editTaskUseCase.execute(taskId, name, description);

      await _taskListBloc.refresh(task.categoryId);
      
      emit(const Success());
    } catch (e) {
      emit(Error(msg: e.toString()));
      return false;
    }
  return true;
  }

  Future<void> refresh(String taskId) async {
    emit(const Input());
    try {
      final TaskEntity task = await _getTaskUseCase.getTask(taskId);
      emit(Loaded(task));
    } catch (e) {
      emit(Error(msg: e.toString()));
    }
  }
}

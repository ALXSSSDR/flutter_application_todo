import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/domain/entities/task.dart';
import 'package:flutter_application_1/domain/usecases/task.dart';
import 'package:flutter_application_1/presentation/states/task/list/bloc.dart';
import 'state.dart';

class TaskEditBloc extends Cubit<TaskEditState> {
  final TaskUseCase _taskUseCase;
  final TaskListBloc _taskListBloc;

  TaskEditBloc(this._taskUseCase, this._taskListBloc)
      : super(const Input());

  Future<bool> editTask(String taskId, String name, String description) async {
    try {
      emit(const Input());

      final TaskEntity task = await _taskUseCase.getTask(taskId);

      await _taskUseCase.editTask(taskId, name, description);

      _taskListBloc.refresh(task.categoryId);
    } catch (e) {
      emit(Error(msg: e.toString()));
      return true;
    }
    return true;
  }

  Future<void> refresh() async {
    emit(const Input());
  }
}
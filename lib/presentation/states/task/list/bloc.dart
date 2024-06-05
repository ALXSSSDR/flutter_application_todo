import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/domain/entities/task.dart';
import 'package:flutter_application_1/domain/usecases/get_tasks.dart';
import 'package:flutter_application_1/domain/usecases/get_task.dart';
import 'package:flutter_application_1/domain/usecases/remove_task.dart';
import 'package:flutter_application_1/domain/usecases/complete_task.dart';
import 'package:flutter_application_1/domain/usecases/favour_task.dart';
import 'state.dart';

class TaskListBloc extends Cubit<TaskListState> {
  final GetTasksUseCase _getTasksUseCase;
  final GetTaskUseCase _getTaskUseCase;
  final RemoveTaskUseCase _removeTaskUseCase;
  final CompleteTaskUseCase _completeTaskUseCase;
  final FavourTaskUseCase _favourTaskUseCase;

  TaskListBloc(
    this._getTasksUseCase,
    this._getTaskUseCase,
    this._removeTaskUseCase,
    this._completeTaskUseCase,
    this._favourTaskUseCase,
  ) : super(const Loading());

  Future<void> refresh(String categoryId) async {
    emit(const Loading());

    try {
      final data = await _getTasksUseCase.getTasks(categoryId); 
      emit(Data(data: data));
    } catch (e) {
      emit(Error(msg: e.toString()));
    }
  }

  Future<bool> removeTask(String taskId) async {
    try {
      final TaskEntity task = await _getTaskUseCase.getTask(taskId);

      await _removeTaskUseCase.execute(task.id);

      await refresh(task.categoryId);
    } catch (e) {
      emit(Error(msg: e.toString()));
      return false;
    }

    return true;
  }

  Future<void> favourTask(String taskId, bool isFavourite) async {
    try {
      await _favourTaskUseCase.execute(taskId, isFavourite);
      final task = await _getTaskUseCase.getTask(taskId);
      await refresh(task.categoryId);
    } catch (e) {
      emit(Error(msg: e.toString()));
    }
  }

  Future<void> completeTask(String taskId, bool isCompleted) async {
    try {
      await _completeTaskUseCase.execute(taskId, isCompleted);
      final task = await _getTaskUseCase.getTask(taskId);
      await refresh(task.categoryId);
    } catch (e) {
      emit(Error(msg: e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/domain/usecases/add_task.dart';
import 'package:flutter_application_1/presentation/states/task/list/bloc.dart';
import 'state.dart';

class TaskAddBloc extends Cubit<TaskAddState> {
  final AddTaskUseCase _addTaskUseCase;
  final TaskListBloc _taskListBloc;

  TaskAddBloc(
    this._addTaskUseCase,
    this._taskListBloc,
  ) : super(const Input());

  Future<bool> addTask(
    String name, String description, String categoryId) async {
    try {
      emit(const Input());

      await _addTaskUseCase.addTask(name, description, categoryId);
      await _taskListBloc.refresh(categoryId);
    } catch (e) {
      emit(Error(msg: e.toString()));
      return false;
    }
    return true;
  }

  Future<void> refresh() async {
    emit(const Input());
  }
}

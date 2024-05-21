import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/domain/usecases/task.dart';
import 'package:flutter_application_1/presentation/states/task/list/bloc.dart';
import 'state.dart';

class TaskAddBloc extends Cubit<TaskAddState> {
  final TaskUseCase _taskUseCase;
  final TaskListBloc _taskListBloc;

  TaskAddBloc(this._taskUseCase, this._taskListBloc)
      : super(const Input());

  Future<bool> addTask(
      String name, String description, String categoryId) async {
    try {
      emit(const Input());

      await _taskUseCase.addTask(name, description, categoryId);
      _taskListBloc.refresh(categoryId);
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
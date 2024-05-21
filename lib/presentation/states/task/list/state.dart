import 'package:flutter_application_1/domain/entities/task.dart';

abstract class TaskListState {
  const TaskListState();
}

class Loading extends TaskListState {
  const Loading();
}

class Data extends TaskListState {
  final List<TaskEntity> data;

  const Data({required this.data});
}

class Error extends TaskListState {
  final String msg;

  const Error({required this.msg});
}

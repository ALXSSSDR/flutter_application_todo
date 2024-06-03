import 'package:flutter_application_1/domain/entities/task.dart';

abstract class TaskEditState {
  const TaskEditState();
}

class Input extends TaskEditState {
  const Input();
}

class Updating extends TaskEditState {
  const Updating();
}

class Error extends TaskEditState {
  final String msg;
  const Error({required this.msg});
}

class Loaded extends TaskEditState {
  final TaskEntity task;
  const Loaded(this.task);
}

class Success extends TaskEditState {
  const Success();
}

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

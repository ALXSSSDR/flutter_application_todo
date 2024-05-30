abstract class TaskAddState {
  const TaskAddState();
}

class Input extends TaskAddState {
  const Input();
}

class Updating extends TaskAddState {
  const Updating();
}

class Error extends TaskAddState {
  final String msg;

  const Error({required this.msg});
}

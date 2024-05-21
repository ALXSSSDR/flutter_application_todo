abstract class CategoryAddState {
  const CategoryAddState();
}

class Input extends CategoryAddState {
  const Input();
}

class Updating extends CategoryAddState {
  const Updating();
}

class Error extends CategoryAddState {
  final String msg;

  const Error({required this.msg});
}


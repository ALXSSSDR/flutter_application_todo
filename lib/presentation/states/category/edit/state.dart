abstract class CategoryEditState {
  const CategoryEditState();
}

class Input extends CategoryEditState {
  const Input();
}

class Updating extends CategoryEditState {
  const Updating();
}

class Error extends CategoryEditState {
  final String msg;

  const Error({required this.msg});
}

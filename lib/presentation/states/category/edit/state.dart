abstract class CategoryEditState {
  const CategoryEditState();
}

class Input extends CategoryEditState {
  const Input();
}

class Loading extends CategoryEditState {
  const Loading();
}

class Success extends CategoryEditState {
  const Success();
}

class Error extends CategoryEditState {
  final String msg;
  const Error({required this.msg});
}
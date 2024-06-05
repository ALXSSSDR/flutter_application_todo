abstract class ImgState {
  const ImgState();
}

class Input extends ImgState {
  const Input();
}

class Loading extends ImgState {
  const Loading();
}

class Error extends ImgState {
  final String msg;
  const Error({required this.msg});
}

class Data extends ImgState {
  final List<String> data;
  final List<String> selectedImgs;

  const Data({required this.data, this.selectedImgs = const []});

  Data copyWith({
    List<String>? data,
    List<String>? selectedImgs,
  }) {
    return Data(
      data: data ?? this.data,
      selectedImgs: selectedImgs ?? this.selectedImgs,
    );
  }
}

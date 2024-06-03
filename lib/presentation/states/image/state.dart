import 'package:flutter/foundation.dart';

@immutable
abstract class ImgState {
  const ImgState();
}

class Input extends ImgState {
  const Input();
}

class Loading extends ImgState {
  const Loading();
}

class Data extends ImgState {
  final List<String> data;

  const Data({required this.data});
}

class Error extends ImgState {
  final String msg;

  const Error({required this.msg});
}


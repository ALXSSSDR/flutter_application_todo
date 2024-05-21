import 'package:flutter_application_1/data/models/filter.dart';

abstract class FilterListState {
  const FilterListState();
}

class Loading extends FilterListState {
  const Loading();
}

class Data extends FilterListState {
  final FilterStatus data;

  const Data({required this.data});
}

class Error extends FilterListState {
  final String msg;

  const Error({required this.msg});
}

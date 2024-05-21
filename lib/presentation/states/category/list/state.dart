import 'package:flutter_application_1/domain/entities/category.dart';

abstract class CategoryListState {
  const CategoryListState();
}

class Loading extends CategoryListState {
  const Loading();
}

class Data extends CategoryListState {
  final List<CategoryEntity> data;

  const Data({required this.data});
}

class Error extends CategoryListState {
  final String msg;

  const Error({required this.msg});
}

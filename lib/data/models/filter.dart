import 'package:drift/drift.dart';
import 'package:flutter_application_1/data/models/category.dart';

enum FilterStatus { all, completed, uncompleted, favourite }

class FilterModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get categoryId => text().references(CategoryModel, #id)();
  IntColumn get name => integer()();
}
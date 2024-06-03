import 'package:drift/drift.dart';
import 'package:flutter_application_1/data/models/task.dart';

class ImgModel extends Table {
  TextColumn get id => text()();
  TextColumn get url => text()();
  TextColumn get taskId => text().references(TaskModel, #id)();
}
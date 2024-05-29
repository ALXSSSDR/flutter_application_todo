import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_application_1/data/models/category.dart';
import 'package:flutter_application_1/data/models/filter.dart';
import 'package:flutter_application_1/data/models/task.dart';

part 'db.g.dart';

@DriftDatabase(tables: [CategoryModel, TaskModel, FilterModel])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> getCategories() async {
    select(categoryModel).get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
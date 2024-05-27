import 'package:flutter_application_1/data/models/category.dart';
import 'package:flutter_application_1/data/models/filter.dart';
import 'package:flutter_application_1/data/models/task.dart';

class LocalDataSource {
  List<CategoryModel> categories = [
    CategoryModel(
      id: '1',
      name: 'category 1',
      createdAt: DateTime.now(),
    ),
    CategoryModel(
      id: '2',
      name: 'category 2',
      createdAt: DateTime.now(),
    ),
  ];

  List<TaskModel> tasks = [
    TaskModel(
      id: '1',
      name: 'task 1',
      createdAt: DateTime.now(),
      description: 'description 1',
      categoryId: '1',
    ),
    TaskModel(
      id: '2',
      name: 'task 2',
      createdAt: DateTime.now(),
      description: 'description 2',
      categoryId: '1',
    ),
    TaskModel(
      id: '3',
      name: 'task 3',
      createdAt: DateTime.now(),
      description: 'description 3',
      categoryId: '2',
    ),
    TaskModel(
      id: '4',
      name: 'task 4',
      createdAt: DateTime.now(),
      description: 'description 4',
      categoryId: '2',
    ),
  ];

  Map<String, FilterStatus> filters = {};
}

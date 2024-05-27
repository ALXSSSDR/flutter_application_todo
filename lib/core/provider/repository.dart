import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/data/datasources/local.dart';
import 'package:flutter_application_1/data/repository/category.dart';
import 'package:flutter_application_1/data/repository/filter.dart';
import 'package:flutter_application_1/data/repository/task.dart';
import 'package:flutter_application_1/domain/repository/category.dart';
import 'package:flutter_application_1/domain/repository/filter.dart';
import 'package:flutter_application_1/domain/repository/task.dart';

final localDataSourceProvider = Provider<LocalDataSource>(
  (ref) => LocalDataSource(),
);

final filterRepositoryProvider = Provider<FilterRepository>(
  (ref) => FilterRepositoryData(ref.watch(localDataSourceProvider)),
);

final taskRepositoryProvider = Provider<TaskRepository>(
  (ref) => TaskRepositoryData(
    dataSource: ref.watch(localDataSourceProvider),
    filterRepository: ref.watch(filterRepositoryProvider),
  ),
);

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepositoryData(ref.watch(localDataSourceProvider)),
);

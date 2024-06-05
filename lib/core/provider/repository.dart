import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/core/provider/db.dart';
import 'package:flutter_application_1/core/provider/mappers.dart';
import 'package:flutter_application_1/data/repository/category.dart';
import 'package:flutter_application_1/data/repository/filter.dart';
import 'package:flutter_application_1/data/repository/task.dart';
import 'package:flutter_application_1/data/repository/image.dart';
import 'package:flutter_application_1/domain/repository/category.dart';
import 'package:flutter_application_1/domain/repository/filter.dart';
import 'package:flutter_application_1/domain/repository/task.dart';
import 'package:flutter_application_1/domain/repository/image.dart';


final filterRepositoryProvider = Provider<FilterRepository>(
  (ref) => FilterRepositoryData(
    db: ref.watch(dbProvider),
    filterMapper: ref.watch(filterMapperProvider),
  ),
);

final taskRepositoryProvider = Provider<TaskRepository>(
  (ref) => TaskRepositoryData(
    db: ref.watch(dbProvider),
    filterRepository: ref.watch(filterRepositoryProvider),
    taskMapper: ref.watch(taskMapperProvider),
  ),
);

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepositoryData(
    db: ref.watch(dbProvider),
    categoryMapper: ref.watch(categoryMapperProvider),
  ),
);


final imgRepositoryProvider = Provider<ImgRepository>(
  (ref) => ImgRepositoryData(
    dio: Dio(),
    imgMapper: ref.watch(imgMapperProvider),
    db: ref.watch(dbProvider),
  ),
);
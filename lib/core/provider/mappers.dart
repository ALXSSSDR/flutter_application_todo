import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/data/mappers/category.dart';
import 'package:flutter_application_1/data/mappers/task.dart';

final categoryMapperProvider = Provider(
  (ref) => CategoryMapper(),
);

final taskMapperProvider = Provider(
  (ref) => TaskMapper(),
);
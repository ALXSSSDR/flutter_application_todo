import 'package:flutter_application_1/domain/entities/filter.dart';
import 'package:flutter_application_1/data/models/filter.dart';


abstract class FilterRepository {
  Future<FilterEntity?> getFilter(String categoryId);

  Future<void> setFilter(FilterStatus status, String categoryId);
}
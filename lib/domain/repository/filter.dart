import 'package:flutter_application_1/data/models/filter.dart';

abstract class FilterRepository {
  Future<FilterStatus> getFilter(String categoryId);

  Future<void> setFilter(FilterStatus status, String categoryId);
}
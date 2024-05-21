import 'package:flutter_application_1/data/datasources/local.dart';
import 'package:flutter_application_1/data/models/filter.dart';
import 'package:flutter_application_1/domain/repository/filter.dart';

class FilterRepositoryData implements FilterRepository {
  @override
  Future<FilterStatus> getFilter(String categoryId) async {
    FilterStatus filter = filters[categoryId] ?? FilterStatus.uncompleted;

    return filter;
  }

  @override
  Future<void> setFilter(FilterStatus status, String categoryId) async {
    filters[categoryId] = status;
  }
}
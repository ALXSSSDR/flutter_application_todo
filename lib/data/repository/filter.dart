import 'package:drift/drift.dart';
import 'package:flutter_application_1/data/datasources/db.dart';
import 'package:flutter_application_1/data/mappers/filter.dart';
import 'package:flutter_application_1/data/models/filter.dart';
import 'package:flutter_application_1/domain/entities/filter.dart';
import 'package:flutter_application_1/domain/repository/filter.dart';

class FilterRepositoryData implements FilterRepository {
  final AppDatabase db;
  final FilterMapper filterMapper;

  FilterRepositoryData({required this.db, required this.filterMapper});

  @override
  Future<FilterEntity?> getFilter(String categoryId) async {
    final filterData = await (db.select(db.filterModel)
          ..where((filter) => filter.categoryId.equals(categoryId)))
        .getSingleOrNull();

    final filter = await filterMapper.mapFilterModel(filterData);

    return filter;
  }

  @override
  Future<void> setFilter(FilterStatus status, String categoryId) async {
    final filter = await getFilter(categoryId);

    if (filter == null) {
      db.into(db.filterModel).insert(await filterMapper
          .mapFilterEntity(FilterEntity(name: status, categoryId: categoryId)));
    } else {
      db.update(db.filterModel)
        ..where((filter) => filter.categoryId.equals(categoryId))
        ..write(
            FilterModelCompanion(name: Value(filterMapper.mapToSql(status))));
    }
  }
}
import 'package:drift/drift.dart';
import 'package:flutter_application_1/data/datasources/db.dart';
import 'package:flutter_application_1/domain/entities/category.dart';

class CategoryMapper {
  CategoryModelCompanion mapCategoryEntity(CategoryEntity category) {
    return CategoryModelCompanion(
      id: Value(category.id),
      name: Value(category.name),
      createdAt: Value(category.createdAt),
    );
  }

  CategoryEntity mapCategoryModel(CategoryModelData category) {
    return CategoryEntity(
      id: category.id,
      name: category.name,
      createdAt: category.createdAt,
    );
  }
}

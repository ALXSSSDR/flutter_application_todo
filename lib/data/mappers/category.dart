import 'package:flutter_application_1/data/models/category.dart';
import 'package:flutter_application_1/domain/entities/category.dart';

class CategoryMapper {
  Future<CategoryModel> mapCategoryEntity(CategoryEntity category) async {
    return CategoryModel(
      id: category.id,
      name: category.name,
      createdAt: category.createdAt,
    );
  }

  Future<CategoryEntity> mapCategoryModel(CategoryModel category) async {
    return CategoryEntity(
      id: category.id,
      name: category.name,
      createdAt: category.createdAt,
    );
  }
}
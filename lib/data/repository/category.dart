import 'package:drift/drift.dart';
import 'package:flutter_application_1/data/datasources/db.dart';
import 'package:flutter_application_1/data/mappers/category.dart';
import 'package:flutter_application_1/domain/entities/category.dart';
import 'package:flutter_application_1/domain/repository/category.dart';

class CategoryRepositoryData implements CategoryRepository {
  final AppDatabase db;
  final CategoryMapper categoryMapper;

  CategoryRepositoryData({required this.db, required this.categoryMapper});

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final categoryData = await db.select(db.categoryModel).get();
    return categoryData.map((category) => categoryMapper.mapCategoryModel(category)).toList();
  }

  @override
  Future<void> addCategory(CategoryEntity category) async {
    final categoryModel = categoryMapper.mapCategoryEntity(category);
    await db.into(db.categoryModel).insert(categoryModel);
  }

  @override
  Future<void> editCategory(String newCategoryName, String oldCategoryName) async {
    await (db.update(db.categoryModel)
      ..where((category) => category.name.equals(oldCategoryName)))
        .write(CategoryModelCompanion(name: Value(newCategoryName.trim())));
  }

  @override
  Future<void> removeCategory(String categoryId) async {
    await (db.delete(db.categoryModel)
          ..where((category) => category.id.equals(categoryId)))
        .go();
    await (db.delete(db.taskModel)
          ..where((task) => task.categoryId.equals(categoryId)))
        .go();
    await (db.delete(db.filterModel)
          ..where((filter) => filter.categoryId.equals(categoryId)))
        .go();
  }

  @override
  Future<bool> categoryAlreadyExist(String categoryName) async {
    final categoryQuery = db.select(db.categoryModel)
      ..where((category) => category.name.equals(categoryName));
    final categories = await categoryQuery.get();
    return categories.isNotEmpty;
  }
}

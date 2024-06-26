import 'package:flutter_application_1/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getCategories();

  Future<void> addCategory(CategoryEntity category);

  Future<void> editCategory(String newCategoryName, String oldCategoryName);

  Future<void> removeCategory(String categoryId);

  Future<bool> categoryAlreadyExist(String categoryName);
}

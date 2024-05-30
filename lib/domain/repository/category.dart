import 'package:flutter_application_1/data/models/category.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> getCategories();

  Future<void> addCategory(CategoryModel category);

  Future<void> editCategory(String newCategoryName, String oldCategoryName);

  Future<void> removeCategory(String categoryId);

  Future<bool> categoryAlreadyExist(String categoryName);
}
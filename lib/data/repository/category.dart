import 'package:flutter_application_1/data/datasources/local.dart';
import 'package:flutter_application_1/data/models/category.dart';
import 'package:flutter_application_1/domain/repository/category.dart';

class CategoryRepositoryData implements CategoryRepository {
  @override
  Future<List<CategoryModel>> getCategories() async {
    return categories;
  }

  @override
  Future<void> addCategory(CategoryModel category) async {
    categories.add(category);
  }

  @override
  Future<void> editCategory(
      String newCategoryName, String oldCategoryName) async {
    CategoryModel category = categories
        .where((category) => (category.name == oldCategoryName))
        .first;

    categories.remove(category);

    categories.add(CategoryModel(
      id: category.id,
      name: category.name,
      createdAt: category.createdAt,
    ));
  }

  @override
  Future<void> removeCategory(String categoryId) async {
    categories.remove(
        categories.where((category) => (category.id == categoryId)).first);
  }

  @override
  Future<bool> categoryAlreadyExist(String categoryName) async {
    return categories
        .where((category) => category.name == categoryName)
        .isNotEmpty;
  }
}
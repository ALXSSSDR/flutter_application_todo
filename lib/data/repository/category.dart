import 'package:flutter_application_1/data/datasources/local.dart';
import 'package:flutter_application_1/data/models/category.dart';
import 'package:flutter_application_1/domain/repository/category.dart';

class CategoryRepositoryData implements CategoryRepository {
  final LocalDataSource dataSource;

  CategoryRepositoryData(this.dataSource);

  @override
  Future<List<CategoryModel>> getCategories() async {
    return dataSource.categories;
  }

  @override
  Future<void> addCategory(CategoryModel category) async {
    dataSource.categories.add(category);
  }

  @override
  Future<void> editCategory(
      String newCategoryName, String oldCategoryName) async {
    CategoryModel category = dataSource.categories
        .where((category) => category.name == oldCategoryName)
        .first;

    dataSource.categories.remove(category);

    dataSource.categories.add(CategoryModel(
      id: category.id,
      name: newCategoryName,
      createdAt: category.createdAt,
    ));
  }

  @override
  Future<void> removeCategory(String categoryId) async {
    dataSource.categories.remove(
        dataSource.categories.where((category) => category.id == categoryId).first);
  }

  @override
  Future<bool> categoryAlreadyExist(String categoryName) async {
    return dataSource.categories
        .where((category) => category.name == categoryName)
        .isNotEmpty;
  }
}

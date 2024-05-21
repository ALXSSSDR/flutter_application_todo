import 'package:flutter_application_1/data/models/category.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> getCategories();

  Future<void> addCategory(CategoryModel category);

  Future<void> removeCategory(String categoryId);

  Future<void> editCategory(String newCategoryName, String oldCategoryName) async {
    print('Редактирование категории с $oldCategoryName на $newCategoryName');
    // Логика обновления категории в хранилище данных
    // Пример кода для обновления категории
    // Например, если используете базу данных:
    // await database.updateCategory(oldCategoryName, newCategoryName);
    print('Категория успешно обновлена с $oldCategoryName на $newCategoryName');
  }


  Future<bool> categoryAlreadyExist(String categoryName);
}
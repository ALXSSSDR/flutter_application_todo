import 'package:flutter_application_1/domain/entities/category.dart';
import 'package:flutter_application_1/domain/repository/category.dart';
import 'package:uuid/uuid.dart';

class AddCategoryUseCase {
  final CategoryRepository categoryRepository;

  AddCategoryUseCase({required this.categoryRepository});

  Future<bool> execute(String newCategoryName) async {
    if (await categoryRepository.categoryAlreadyExist(newCategoryName)) {
      return false;
    }

    CategoryEntity category = CategoryEntity(
      id: const Uuid().v4(),
      name: newCategoryName.trim(),
      createdAt: DateTime.now(),
    );

    await categoryRepository.addCategory(category);

    return true;
  }
}

import 'package:flutter_application_1/domain/repository/category.dart';

class EditCategoryUseCase {
  final CategoryRepository categoryRepository;

  EditCategoryUseCase({
    required this.categoryRepository,
  });

  Future<bool> execute(String newCategoryName, String oldCategoryName) async {
    if (await categoryRepository.categoryAlreadyExist(newCategoryName)) {
      return false;
    }
    await categoryRepository.editCategory(newCategoryName, oldCategoryName);
    return true;
  }
}

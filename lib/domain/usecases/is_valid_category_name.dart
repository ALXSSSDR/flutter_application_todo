import 'package:flutter_application_1/domain/repository/category.dart';

class IsValidCategoryNameUseCase {
  final CategoryRepository categoryRepository;

  IsValidCategoryNameUseCase({
    required this.categoryRepository,
  });

  Future<bool> execute(String name) async {
    return !(await categoryRepository.categoryAlreadyExist(name));
  }
}

import 'package:flutter_application_1/domain/repository/category.dart';

class RemoveCategoryUseCase {
  final CategoryRepository categoryRepository;

  RemoveCategoryUseCase({
    required this.categoryRepository,
  });

  Future<void> execute(String categoryId) async {
    await categoryRepository.removeCategory(categoryId);
  }
}

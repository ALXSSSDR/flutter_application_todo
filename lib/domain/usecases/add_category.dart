import 'package:flutter_application_1/domain/entities/category.dart';
import 'package:flutter_application_1/domain/repository/category.dart';
import 'package:flutter_application_1/data/mappers/category.dart';
import 'package:uuid/uuid.dart';

class AddCategoryUseCase {
  final CategoryRepository categoryRepository;
  final CategoryMapper categoryMapper;

  AddCategoryUseCase({
    required this.categoryRepository,
    required this.categoryMapper,
  });

  Future<bool> execute(String newCategoryName) async {
    if (await categoryRepository.categoryAlreadyExist(newCategoryName)) {
      return false;
    }

    CategoryEntity category = CategoryEntity(
      id: const Uuid().v4(),
      name: newCategoryName.trim(),
      createdAt: DateTime.now(),
    );

    await categoryRepository.addCategory(await categoryMapper.mapCategoryEntity(category));

    return true;
  }
}

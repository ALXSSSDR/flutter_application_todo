import 'package:flutter_application_1/domain/entities/category.dart';
import 'package:flutter_application_1/domain/repository/category.dart';
import 'package:flutter_application_1/data/mappers/category.dart';

class GetCategoriesUseCase {
  final CategoryRepository categoryRepository;
  final CategoryMapper categoryMapper;

  GetCategoriesUseCase({
    required this.categoryRepository,
    required this.categoryMapper,
  });

  Future<List<CategoryEntity>> execute() async {
    List<CategoryEntity> categoriesData = await categoryRepository.getCategories();
    categoriesData.sort((a, b) => a.name.compareTo(b.name));
    return categoriesData;
  }
}

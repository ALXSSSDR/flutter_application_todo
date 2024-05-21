import 'package:flutter_application_1/data/mappers/category.dart';
import 'package:flutter_application_1/domain/entities/category.dart';
import 'package:flutter_application_1/domain/repository/category.dart';

class GetCategoriesUseCase {
  final CategoryRepository categoryRepository;
  final CategoryMapper categoryMapper;

  GetCategoriesUseCase({
    required this.categoryRepository,
    required this.categoryMapper,
  });

  Future<List<CategoryEntity>> execute() async {
    List categoriesData = await categoryRepository.getCategories();

    List<CategoryEntity> categories = await Future.wait(categoriesData
        .map((categoryModel) async =>
            await categoryMapper.mapCategoryModel(categoryModel))
        .toList());

    categories.sort((a, b) => a.name.compareTo(b.name));
    return categories;
  }
}

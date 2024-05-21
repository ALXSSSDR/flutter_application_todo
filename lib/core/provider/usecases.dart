import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/core/provider/mappers.dart';
import 'package:flutter_application_1/core/provider/repository.dart';
import '../../domain/usecases/add_category.dart';
import '../../domain/usecases/edit_category.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/is_valid_category_name.dart';
import '../../domain/usecases/remove_category.dart';
import 'package:flutter_application_1/domain/usecases/filter.dart';
import 'package:flutter_application_1/domain/usecases/task.dart';

final addCategoryUseCaseProvider = Provider<AddCategoryUseCase>(
  (ref) => AddCategoryUseCase(
    categoryRepository: ref.watch(categoryRepositoryProvider),
    categoryMapper: ref.watch(categoryMapperProvider),
  ),
);

final removeCategoryUseCaseProvider = Provider<RemoveCategoryUseCase>(
  (ref) => RemoveCategoryUseCase(
    categoryRepository: ref.watch(categoryRepositoryProvider),
  ),
);

final isValidCategoryNameUseCaseProvider = Provider<IsValidCategoryNameUseCase>(
  (ref) => IsValidCategoryNameUseCase(
    categoryRepository: ref.watch(categoryRepositoryProvider),
  ),
);

final getCategoriesUseCaseProvider = Provider<GetCategoriesUseCase>(
  (ref) => GetCategoriesUseCase(
    categoryRepository: ref.watch(categoryRepositoryProvider),
    categoryMapper: ref.watch(categoryMapperProvider),
  ),
);

final editCategoryUseCaseProvider = Provider<EditCategoryUseCase>(
  (ref) => EditCategoryUseCase(
    categoryRepository: ref.watch(categoryRepositoryProvider),
  ),
);

final filterUseCaseProvider = Provider(
  (ref) => FilterUseCase(
    filterRepository: ref.watch(filterRepositoryProvider),
  ),
);

final taskUseCaseProvider = Provider(
  (ref) => TaskUseCase(
    taskRepository: ref.watch(taskRepositoryProvider),
    taskMapper: ref.watch(taskMapperProvider),
    filterUseCase: ref.watch(filterUseCaseProvider),
  ),
);
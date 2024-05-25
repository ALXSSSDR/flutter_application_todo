import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/core/provider/mappers.dart';
import 'package:flutter_application_1/core/provider/repository.dart';
import '../../domain/usecases/add_category.dart';
import '../../domain/usecases/edit_category.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/is_valid_category_name.dart';
import '../../domain/usecases/remove_category.dart';
import '../../domain/usecases/filter.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/edit_task.dart';
import '../../domain/usecases/get_task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/remove_task.dart';
import '../../domain/usecases/complete_task.dart';
import '../../domain/usecases/favour_task.dart';

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

final filterUseCaseProvider = Provider<FilterUseCase>(
  (ref) => FilterUseCase(
    filterRepository: ref.watch(filterRepositoryProvider),
  ),
);

final addTaskUseCaseProvider = Provider<AddTaskUseCase>(
  (ref) => AddTaskUseCase(
    taskRepository: ref.watch(taskRepositoryProvider),
    taskMapper: ref.watch(taskMapperProvider),
  ),
);

final editTaskUseCaseProvider = Provider<EditTaskUseCase>(
  (ref) => EditTaskUseCase(
    taskRepository: ref.watch(taskRepositoryProvider),
  ),
);

final getTaskUseCaseProvider = Provider<GetTaskUseCase>(
  (ref) => GetTaskUseCase(
    taskRepository: ref.watch(taskRepositoryProvider),
    taskMapper: ref.watch(taskMapperProvider),
  ),
);

final getTasksUseCaseProvider = Provider<GetTasksUseCase>(
  (ref) => GetTasksUseCase(
    filterUseCase: ref.watch(filterUseCaseProvider),
    taskRepository: ref.watch(taskRepositoryProvider),
    taskMapper: ref.watch(taskMapperProvider),
  ),
);

final removeTaskUseCaseProvider = Provider<RemoveTaskUseCase>(
  (ref) => RemoveTaskUseCase(
    taskRepository: ref.watch(taskRepositoryProvider),
  ),
);

final completeTaskUseCaseProvider = Provider<CompleteTaskUseCase>(
  (ref) => CompleteTaskUseCase(
    taskRepository: ref.watch(taskRepositoryProvider),
  ),
);

final favourTaskUseCaseProvider = Provider<FavourTaskUseCase>(
  (ref) => FavourTaskUseCase(
    taskRepository: ref.watch(taskRepositoryProvider),
  ),
);

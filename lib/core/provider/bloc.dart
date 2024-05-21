import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/core/provider/mappers.dart';
import 'package:flutter_application_1/core/provider/repository.dart';
import 'package:flutter_application_1/domain/usecases/add_category.dart';
import 'package:flutter_application_1/domain/usecases/edit_category.dart';
import 'package:flutter_application_1/domain/usecases/get_categories.dart';
import 'package:flutter_application_1/domain/usecases/is_valid_category_name.dart';
import 'package:flutter_application_1/domain/usecases/remove_category.dart';
import 'package:flutter_application_1/domain/usecases/filter.dart';
import 'package:flutter_application_1/domain/usecases/task.dart';
import 'package:flutter_application_1/presentation/states/category/add/bloc.dart';
import 'package:flutter_application_1/presentation/states/category/edit/bloc.dart';
import 'package:flutter_application_1/presentation/states/category/list/bloc.dart';
import 'package:flutter_application_1/presentation/states/filter/bloc.dart';
import 'package:flutter_application_1/presentation/states/task/add/bloc.dart';
import 'package:flutter_application_1/presentation/states/task/edit/bloc.dart';
import 'package:flutter_application_1/presentation/states/task/list/bloc.dart';

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

final categoryListBlocProvider = Provider(
  (ref) {
    return CategoryListBloc(
      ref.watch(getCategoriesUseCaseProvider),
      ref.watch(removeCategoryUseCaseProvider),
    );
  },
);
final categoryAddBlocProvider = Provider(
  (ref) => CategoryAddBloc(
    ref.watch(addCategoryUseCaseProvider),
    ref.watch(isValidCategoryNameUseCaseProvider),
    ref.watch(getCategoriesUseCaseProvider)
  ),
);

final categoryEditBlocProvider = Provider(
  (ref) {
    return CategoryEditBloc(
      ref.watch(editCategoryUseCaseProvider),
      ref.watch(isValidCategoryNameUseCaseProvider),
      ref.watch(categoryListBlocProvider),
    );
  },
);

final taskListBlocProvider = Provider(
  (ref) => TaskListBloc(
    ref.watch(taskUseCaseProvider),
  ),
);

final taskAddBlocProvider = Provider(
  (ref) => TaskAddBloc(
    ref.watch(taskUseCaseProvider),
    ref.watch(taskListBlocProvider),
  ),
);

final taskEditBlocProvider = Provider(
  (ref) => TaskEditBloc(
    ref.watch(taskUseCaseProvider),
    ref.watch(taskListBlocProvider),
  ),
);

final filterListBlocProvider = Provider(
  (ref) => FilterListBloc(
    ref.watch(filterUseCaseProvider), 
    ref.watch(taskListBlocProvider)
  ),
);

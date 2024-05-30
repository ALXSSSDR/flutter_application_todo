import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/domain/usecases/edit_category.dart';
import 'package:flutter_application_1/domain/usecases/is_valid_category_name.dart';
import 'package:flutter_application_1/presentation/states/category/list/bloc.dart';
import 'state.dart';

class CategoryEditBloc extends Cubit<CategoryEditState> {
  final EditCategoryUseCase _editCategoryUseCase;
  final IsValidCategoryNameUseCase _isValidCategoryNameUseCase;
  final CategoryListBloc _categoryListBloc;

  CategoryEditBloc(
    this._editCategoryUseCase,
    this._isValidCategoryNameUseCase,
    this._categoryListBloc,
  ) : super(const Input());

  Future<bool> editCategory({
    required String newCategoryName,
    required String oldCategoryName,
  }) async {
    try {
      emit(const Loading());

      if (!await _isValidCategoryNameUseCase.execute(newCategoryName)) {
        emit(const Error(msg: 'Такая категория уже существует'));
        return false;
      }

      if (!await _editCategoryUseCase.execute(newCategoryName, oldCategoryName)) {
        emit(const Error(msg: 'Ошибка при изменении категории'));
        return false;
      }

      await _categoryListBloc.refresh();
      emit(const Success());
    } catch (e) {
      emit(Error(msg: e.toString()));
      return false;
    }

    return true;
  }

  Future<void> refresh() async {
    emit(const Loading());
    // Здесь вы можете добавить логику для обновления состояния блока, если это необходимо.
    emit(const Input());
  }
}

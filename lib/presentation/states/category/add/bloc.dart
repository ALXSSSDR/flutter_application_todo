import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/domain/usecases/add_category.dart';
import 'package:flutter_application_1/domain/usecases/is_valid_category_name.dart';
import 'package:flutter_application_1/domain/usecases/get_categories.dart'; 
import 'state.dart';

class CategoryAddBloc extends Cubit<CategoryAddState> {
  final AddCategoryUseCase _addCategoryUseCase;
  final IsValidCategoryNameUseCase _isValidCategoryNameUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase; 

  CategoryAddBloc(
    this._addCategoryUseCase,
    this._isValidCategoryNameUseCase,
    this._getCategoriesUseCase, 
  ) : super(const Input());

  Future<bool> addCategory(String newCategoryName) async {
    try {
      emit(const Input());

      if (!await _isValidCategoryNameUseCase.execute(newCategoryName)) {
        emit(const Error(msg: 'Такая категория уже существует'));
        return false;
      }
      await _addCategoryUseCase.execute(newCategoryName);
      
      await _getCategoriesUseCase.execute();
      
    } catch (e) {
      emit(Error(msg: e.toString()));
      return true;
    }
    return true;
  }

  Future<void> refresh() async {
    emit(const Input());
  }
}

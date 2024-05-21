import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/domain/usecases/get_categories.dart';
import 'package:flutter_application_1/domain/usecases/remove_category.dart';
import 'state.dart';

class CategoryListBloc extends Cubit<CategoryListState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final RemoveCategoryUseCase _removeCategoryUseCase;

  CategoryListBloc(this._getCategoriesUseCase, this._removeCategoryUseCase)
      : super(const Loading());

  Future<void> refresh() async {
    try {
      emit(const Loading());
      final data = await _getCategoriesUseCase.execute();
      emit(Data(data: data));
    } catch (e) {
      emit(Error(msg: e.toString()));
    }
  }

  Future<bool> removeCategory(String categoryId) async {
    try {
      await _removeCategoryUseCase.execute(categoryId);
      await refresh();
    } catch (e) {
      emit(Error(msg: e.toString()));
      return false;
    }
    return true;
  }
}

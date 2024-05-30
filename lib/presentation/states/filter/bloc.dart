import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/data/models/filter.dart';
import 'package:flutter_application_1/domain/usecases/filter.dart';
import 'package:flutter_application_1/presentation/states/task/list/bloc.dart';
import 'state.dart';

class FilterListBloc extends Cubit<FilterListState> {
  final FilterUseCase _filterUseCase;
  final TaskListBloc _taskListBloc;

  FilterListBloc(this._filterUseCase, this._taskListBloc)
      : super(const Loading());

  Future<void> refresh(String categoryId) async {
    emit(const Loading());

    final FilterStatus data = await _filterUseCase.getFilter(categoryId);

    _taskListBloc.refresh(categoryId);

    emit(Data(data: data));
  }

  Future<void> setFilter(String categoryId, FilterStatus filterStatus) async {
    try {
      await _filterUseCase.setFilter(filterStatus, categoryId);
      refresh(categoryId);
    } catch (e) {
      emit(Error(msg: e.toString()));
    }
  }

  Future<FilterStatus?> getFilter(String categoryId) async {
    return _filterUseCase.getFilter(categoryId);
  }
}
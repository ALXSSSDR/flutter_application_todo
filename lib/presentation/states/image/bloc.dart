import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/domain/usecases/image.dart';
import 'package:flutter_application_1/presentation/states/task/edit/bloc.dart';
import 'state.dart';

class ImgBloc extends Cubit<ImgState> {
  final ImgUseCase _imgUseCase;
  final TaskEditBloc _taskBloc;

  ImgBloc(this._imgUseCase, this._taskBloc) : super(const Input());

  Future<void> showImgs(String query, int page, int perPage) async {
    emit(const Loading());
    try {
      final List<String> data = await _imgUseCase.getImgs(query, page, perPage);

      if (data.isEmpty) {
        emit(const Error(msg: 'Изображения не найдены'));
        return;
      }

      emit(Data(data: data));
    } catch (e) {
      emit(Error(msg: 'Произошла ошибка: $e'));
    }
  }

  Future<void> reset() async {
    emit(const Input());
  }

  Future<void> addImgs(String taskId, List<String> imgUrls) async {
    try {
      await _imgUseCase.addImgs(taskId, imgUrls);
      _taskBloc.refresh(taskId);
    } catch (e) {
      emit(Error(msg: 'Не удалось добавить изображения: $e'));
    }
  }

  Future<void> removeImg(String taskId, String imgId) async {
    try {
      await _imgUseCase.removeImg(imgId);
      _taskBloc.refresh(taskId);
    } catch (e) {
      emit(Error(msg: 'Не удалось удалить изображение: $e'));
    }
  }

  void addSelectedImg(String imgUrl) {
    if (state is Data) {
      final currentState = state as Data;
      final updatedSelectedImgs = List<String>.from(currentState.selectedImgs)..add(imgUrl);
      emit(currentState.copyWith(selectedImgs: updatedSelectedImgs));
    }
  }

  void removeSelectedImg(String imgUrl) {
    if (state is Data) {
      final currentState = state as Data;
      final updatedSelectedImgs = List<String>.from(currentState.selectedImgs)..remove(imgUrl);
      emit(currentState.copyWith(selectedImgs: updatedSelectedImgs));
    }
  }
}

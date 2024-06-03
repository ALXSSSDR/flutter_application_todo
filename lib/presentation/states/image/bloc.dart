import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/domain/usecases/image.dart';
import 'package:flutter_application_1/presentation/states/task/edit/bloc.dart';
import 'state.dart';

class ImgBloc extends Cubit<ImgState> {
  final ImgUseCase _imgkUseCase;
  final TaskEditBloc _taskBloc;

  ImgBloc(this._imgkUseCase, this._taskBloc) : super(const Input());

  Future<void> showImgs(String query, int page, int perPage) async {
    emit(const Loading());
    final List<String> data = await _imgkUseCase.getImgs(query, page, perPage);

    if (data.isEmpty) {
      var t;
      emit(Error(msg: t.task.noImgs));
      return;
    }

    emit(Data(data: data));
  }

  Future<void> reset() async {
    emit(const Input());
  }

  Future<void> addImgs(String taskId, List<String> imgUrls) async {
    _imgkUseCase.addImgs(taskId, imgUrls);
    _taskBloc.refresh(taskId);
  }

  Future<void> removeImg(String taskId, String imgId) async {
    _imgkUseCase.removeImg(imgId);
    _taskBloc.refresh(taskId);
  }
}
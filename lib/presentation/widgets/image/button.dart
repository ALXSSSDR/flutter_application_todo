import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/core/provider/bloc.dart';
import 'package:flutter_application_1/domain/entities/task.dart';
import 'package:flutter_application_1/presentation/states/image/bloc.dart';
import 'package:flutter_application_1/presentation/states/image/state.dart';

class ImgButton extends ConsumerWidget {
  final TextEditingController searchController;
  final TextEditingController perPageController;
  final TextEditingController pageController;

  final List<String> selectedImgs;
  final TaskEntity task;

  const ImgButton({
    super.key,
    required this.searchController,
    required this.perPageController,
    required this.pageController,
    required this.selectedImgs,
    required this.task,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = ref.watch(imgBlocProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: BlocBuilder<ImgBloc, ImgState>(
        bloc: bloc,
        builder: (_, state) => ElevatedButton(
          onPressed: () {
            if (state is Input || state is Error) {
              bloc.showImgs(
                searchController.text,
                int.parse(pageController.text),
                int.parse(perPageController.text),
              );
              FocusScope.of(context).unfocus();
            } else if (state is Data) {
              bloc.addImgs(task.id, selectedImgs);
              Navigator.of(context).pop();
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                (Theme.of(context).brightness == Brightness.dark)
                    ? Colors.white
                    : Colors.black),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          child: _buildButtonChild(context, state),
        ),
      ),
    );
  }

  Widget _buildButtonChild(BuildContext context, ImgState state) {
    if (state is Loading) {
      return const Center(
        child: SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.black,
          ),
        ),
      );
    } else {
      return SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(
            state is Data ? 'Добавить' : 'Отправить',
            style: TextStyle(
              color: (Theme.of(context).brightness == Brightness.dark)
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      );
    }
  }
}

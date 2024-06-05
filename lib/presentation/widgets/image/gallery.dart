import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/core/provider/bloc.dart';
import 'package:flutter_application_1/presentation/states/image/bloc.dart';
import 'package:flutter_application_1/presentation/states/image/state.dart';
import 'package:flutter_application_1/presentation/widgets/image/image.dart';

class ImgGallery extends ConsumerWidget {
  final TextEditingController perPageController;
  final List<String> selectedImgs;

  const ImgGallery({
    super.key,
    required this.perPageController,
    required this.selectedImgs,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = ref.watch(imgBlocProvider);
    return BlocBuilder<ImgBloc, ImgState>(
      bloc: bloc,
      builder: (_, state) {
        if (state is Error) {
          return SizedBox(
            height: 30,
            width: double.infinity,
            child: Center(child: Text(state.msg)),
          );
        } else if (state is Input || state is Loading) {
          return const SizedBox.shrink();
        } else if (state is Data) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 400,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: int.parse(perPageController.text),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => ImgItem(
                  photos: state.data,
                  index: index,
                  selectedImgs: selectedImgs,
                ),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/states/image/bloc.dart';
import 'package:flutter_application_1/presentation/states/image/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/core/provider/bloc.dart';
import 'package:flutter_application_1/domain/entities/task.dart';
import 'package:flutter_application_1/presentation/widgets/image/button.dart';
import 'package:flutter_application_1/presentation/widgets/image/gallery.dart';
import 'package:flutter_application_1/presentation/widgets/image/text_field.dart';

class ImgWidget extends ConsumerStatefulWidget {
  final TaskEntity task;

  const ImgWidget({super.key, required this.task});

  @override
  ConsumerState<ImgWidget> createState() => _ImgWidgetState();
}

class _ImgWidgetState extends ConsumerState<ImgWidget> {
  late final GlobalKey<FormState> searchKey;
  late final GlobalKey<FormState> perPageKey;
  late final GlobalKey<FormState> pageKey;

  late final TextEditingController searchController;
  late final TextEditingController perPageController;
  late final TextEditingController pageController;

  @override
  void initState() {
    super.initState();
    searchKey = GlobalKey<FormState>();
    perPageKey = GlobalKey<FormState>();
    pageKey = GlobalKey<FormState>();

    searchController = TextEditingController();
    perPageController = TextEditingController(text: "20");
    pageController = TextEditingController(text: "1");
  }

  @override
  void dispose() {
    searchController.dispose();
    perPageController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = ref.read(imgBlocProvider); 
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: WillPopScope(
        onWillPop: () async {
          bloc.reset();
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0) +
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImgTextField(
                searchController: searchController,
                perPageController: perPageController,
                pageController: pageController,
                searchKey: searchKey,
                perPageKey: perPageKey,
                pageKey: pageKey,
              ),
              BlocBuilder<ImgBloc, ImgState>(
                bloc: bloc,
                builder: (context, state) {
                  List<String> selectedImgs = [];
                  if (state is Data) {
                    selectedImgs = state.selectedImgs;
                  }
                  return ImgGallery(
                    perPageController: perPageController,
                    selectedImgs: selectedImgs,
                  );
                },
              ),
              BlocBuilder<ImgBloc, ImgState>(
                bloc: bloc,
                builder: (context, state) {
                  List<String> selectedImgs = [];
                  if (state is Data) {
                    selectedImgs = state.selectedImgs;
                  }
                  return ImgButton(
                    searchController: searchController,
                    perPageController: perPageController,
                    pageController: pageController,
                    task: widget.task,
                    selectedImgs: selectedImgs,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/core/provider/bloc.dart';
import 'package:flutter_application_1/presentation/states/image/bloc.dart';
import 'package:flutter_application_1/presentation/states/image/state.dart';

class ImgTextField extends ConsumerWidget {
  final GlobalKey<FormState> searchKey;
  final GlobalKey<FormState> perPageKey;
  final GlobalKey<FormState> pageKey;

  final TextEditingController searchController;
  final TextEditingController perPageController;
  final TextEditingController pageController;

  const ImgTextField({
    super.key,
    required this.searchController,
    required this.perPageController,
    required this.pageController,
    required this.searchKey,
    required this.perPageKey,
    required this.pageKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = ref.watch(imgBlocProvider);
    return BlocBuilder<ImgBloc, ImgState>(
      bloc: bloc,
      builder: (_, state) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Form(
                key: searchKey,
                child: TextFormField(
                  minLines: 1,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  autofocus: true,
                  enableInteractiveSelection: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: 'Введите название фото',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          width: 2),
                    ),
                  ),
                  controller: searchController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите корректное значение';
                    }
                    return null;
                  },
                  onTap: () {
                    if (state is Data) {
                      bloc.reset();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            Expanded(
              flex: 1,
              child: TextFormField(
                key: perPageKey,
                textAlign: TextAlign.center,
                minLines: 1,
                maxLines: 1,
                keyboardType: TextInputType.multiline,
                enableInteractiveSelection: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        width: 2),
                  ),
                ),
                controller: perPageController,
                onTap: () {
                  if (state is Data) {
                    bloc.reset();
                  }
                },
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            Expanded(
              flex: 1,
              child: TextFormField(
                key: pageKey,
                textAlign: TextAlign.center,
                minLines: 1,
                maxLines: 1,
                keyboardType: TextInputType.multiline,
                enableInteractiveSelection: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        width: 2),
                  ),
                ),
                controller: pageController,
                onTap: () {
                  if (state is Data) {
                    bloc.reset();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
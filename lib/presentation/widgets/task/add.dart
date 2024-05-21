import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/states/task/add/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/core/provider/bloc.dart';
import 'package:flutter_application_1/domain/entities/category.dart';
import 'package:flutter_application_1/presentation/states/task/add/bloc.dart' as AddBloc;
import 'package:flutter_application_1/presentation/states/task/add/state.dart' as AddState;

class TaskAddWidget extends ConsumerStatefulWidget {
  final CategoryEntity category;

  const TaskAddWidget({Key? key, required this.category}) : super(key: key);

  @override
  _TaskAddWidgetState createState() => _TaskAddWidgetState();
}

class _TaskAddWidgetState extends ConsumerState<TaskAddWidget> {
  late final GlobalKey<FormState> _nameKey;
  late final GlobalKey<FormState> _descriptionKey;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _nameKey = GlobalKey<FormState>();
    _descriptionKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = ref.watch(taskAddBlocProvider);

    return PopScope(
      onPopInvoked: (didPop) async {
        await Future.delayed(const Duration(milliseconds: 250));
        bloc.refresh();
      },
      child: BlocBuilder<AddBloc.TaskAddBloc, AddState.TaskAddState>(
        bloc: bloc,
        builder: (_, state) {
          if (state is Input) {
            return Padding(
              padding: const EdgeInsets.all(18.0) +
                  EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _nameKey,
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.multiline,
                      autofocus: true,
                      enableInteractiveSelection: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: 'Название задачи',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              width: 2),
                        ),
                        counterText: "",
                      ),
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Поле не должно быть пустым';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    minLines: 4,
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    autofocus: true,
                    key: _descriptionKey,
                    enableInteractiveSelection: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: 'Описание задачи',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                            width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                            width: 2),
                      ),
                      counterText: "",
                    ),
                    controller: _descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Поле не должно быть пустым';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (!(_nameKey.currentState?.validate() ?? false)) {
                        return;
                      }

                      if (await bloc.addTask(_nameController.text,
                              _descriptionController.text, widget.category.id) &&
                          context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Добавить',
                          style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is Updating) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Error) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Expanded(child: Center(child: Text(state.msg))),
                  ElevatedButton(
                    onPressed: bloc.refresh,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Добавить',
                          style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

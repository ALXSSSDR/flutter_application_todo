import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/core/provider/bloc.dart';
import 'package:flutter_application_1/domain/entities/task.dart';
import 'package:intl/intl.dart';

class TaskEditWidget extends ConsumerStatefulWidget {
  final TaskEntity task;

  const TaskEditWidget({super.key, required this.task});

  @override
  ConsumerState<TaskEditWidget> createState() => _TaskEditWidgetState();
}

class _TaskEditWidgetState extends ConsumerState<TaskEditWidget> {
  late final GlobalKey<FormState> _nameKey;
  late final GlobalKey<FormState> _descriptionKey;

  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  final ScrollController _scrollController = ScrollController();

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

    _nameController = TextEditingController(text: widget.task.name);
    _descriptionController =
        TextEditingController(text: widget.task.description);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = ref.watch(taskEditBlocProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        _scrollController.animateTo(
          0.0,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 300),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0) +
            EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: ListView(
          controller: _scrollController,
          children: [
            
            const SizedBox(
              height: 14,
            ),
            const Text(
              'Название задачи',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 14,
            ),
            Form(
              key: _nameKey,
              child: TextFormField(
                minLines: 1,
                maxLines: 1,
                keyboardType: TextInputType.multiline,
                enableInteractiveSelection: true,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: 'Название задачи',
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
                    counterText: ""),
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
            const Text(
              'Описание задачи',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 14,
            ),
            TextFormField(
              minLines: 9,
              maxLines: 100,
              keyboardType: TextInputType.multiline,
              key: _descriptionKey,
              enableInteractiveSelection: true,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  hintText: 'Описание задачи',
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
                  counterText: ""),
              controller: _descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Поле не должно быть пустым';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              '${'Создано'}: ${DateFormat('hh:mm dd.MM.yyyy').format(widget.task.createdAt)}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            ElevatedButton(
              onPressed: () {
                if (!(_nameKey.currentState?.validate() ?? false)) {
                  return;
                }

                bloc.editTask(widget.task.id, _nameController.text,
                    _descriptionController.text);

                Navigator.of(context).pop();
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
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Подтвердить',
                    style: TextStyle(
                        color: (Theme.of(context).brightness == Brightness.dark)
                            ? Colors.black
                            : Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
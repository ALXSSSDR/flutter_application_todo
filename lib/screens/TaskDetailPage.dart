import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class TaskDetailPage extends StatefulWidget {
  final Task task;
  final Function(Task) onTaskDeleted;
  final Function(Task) onTaskSaved;

  const TaskDetailPage({
    super.key,
    required this.task,
    required this.onTaskDeleted,
    required this.onTaskSaved,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
  }

  void _showDeleteConfirmationDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Подтверждение удаления'),
          content: const Text('Вы уверены, что хотите удалить задачу?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                widget.onTaskDeleted(widget.task);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Удалить'),
            ),
          ],
        );
      },
    );
  }

  void _showSaveConfirmationDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Сохранить изменения?'),
          content: const Text('Вы уверены, что хотите сохранить внесенные изменения?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                widget.onTaskSaved(
                  Task(
                    id: widget.task.id,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    categoryId: widget.task.categoryId,
                    isCompleted: widget.task.isCompleted,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Сохранить'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _titleController,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          onChanged: (value) {
            _titleController.text = value;
            _titleController.selection = TextSelection.fromPosition(
              TextPosition(offset: _titleController.text.length),
            );
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text('Дата изменения:   '),
                      Text(DateFormat('dd.MM.yyyy').format(DateTime.now())),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _descriptionController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      labelText: "Описание",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: _showDeleteConfirmationDialog,
            child: const Text("Удалить"),
          ),
          ElevatedButton(
            onPressed: _showSaveConfirmationDialog,
            child: const Text("Сохранить"),
          ),
        ],
      ),
    );
  }
}
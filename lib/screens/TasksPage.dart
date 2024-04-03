import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';
import 'TaskDetailPage.dart';

class TasksPage extends StatefulWidget {
  final String categoryName;
  final String categoryId;
  List<Task> tasks;
  TasksPage({Key? key, required this.categoryName, required this.categoryId, required this.tasks});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  String _filterType = "Все";

  void _showTaskDetailPage(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskDetailPage(
        task: task,
        onTaskDeleted: (deletedTask) {
          setState(() {
            widget.tasks.removeWhere((t) => t.id == deletedTask.id); 
          });
        },
        onTaskSaved: (updatedTask) {
          int index = widget.tasks.indexWhere((t) => t.id == updatedTask.id); 
          setState(() {
            widget.tasks[index] = updatedTask; 
          });
        },
      )),
    );
  }

  void _addTask(String taskTitle) {
    final uuid = Uuid();
    final newTask = Task(id: uuid.v4(), title: taskTitle, categoryId: widget.categoryId);
    setState(() {
      widget.tasks.add(newTask);
    });
  }

  void _toggleTaskCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  void _toggleTaskFavourite(Task task) {
    setState(() {
      task.isFavourite = !task.isFavourite;
    });
  }

  void _removeTask(String id) {
    setState(() {
      widget.tasks.removeWhere((task) => task.id == id);
    });
  }

  void _showAddTaskDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String taskTitle = '';
        return AlertDialog(
          title: const Text('Добавить новую задачу'),
          content: TextField(
            onChanged: (value) {
              taskTitle = value;
            },
            autofocus: true,
            decoration: const InputDecoration(hintText: "Название задачи"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                if (taskTitle.isNotEmpty) {
                  _addTask(taskTitle);
                  Navigator.pop(context, 'OK');
                }
              },
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Task> _filteredTasks = widget.tasks.where((task) {
      switch (_filterType) {
        case "Завершенные":
          return task.categoryId == widget.categoryId && task.isCompleted;
        case "Незавершенные":
          return task.categoryId == widget.categoryId && !task.isCompleted;
        case "Избранные":
          return task.categoryId == widget.categoryId && task.isFavourite;
        default:
          return task.categoryId == widget.categoryId;
      }
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                _filterType = value;
              });
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(value: "Все", child: Text("Все")),
                const PopupMenuItem(value: "Завершенные", child: Text("Завершенные")),
                const PopupMenuItem(value: "Незавершенные", child: Text("Незавершенные")),
                const PopupMenuItem(value: "Избранные", child: Text("Избранные")),
              ];
            },
          ),
        ],
      ),
      body: _filteredTasks.isEmpty
          ? const Center(
              child: Text('Пока что у вас нет задач'),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Text(
                    '$_filterType задачи',
                    style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = _filteredTasks[index];
                      return Dismissible(
                        key: Key(task.id),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            _removeTask(task.id);
                          }
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: Card(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: ListTile(
                            title: Text(task.title),
                            leading: IconButton(
                              icon: Icon(task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank),
                              onPressed: () => _toggleTaskCompletion(task),
                            ),
                            trailing: IconButton(
                              icon: Icon(task.isFavourite ? Icons.star : Icons.star_border, color: Colors.yellow[700]),
                              onPressed: () => _toggleTaskFavourite(task),
                            ),
                            onTap: () => _showTaskDetailPage(task), 
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        tooltip: 'Добавить задачу',
        backgroundColor: const Color.fromARGB(255, 127, 224, 216),
        child: const Icon(Icons.add),
      ),
    );
  }
}
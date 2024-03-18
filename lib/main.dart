import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 101, 221, 205),
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1)),
        ),
      ),
      home: const MyHomePage(title: 'ToDo'),
    );
  }
}

class Category {
  String id;
  String name;

  Category({required this.id, required this.name});
}

class Task {
  String id;
  String title;
  bool isCompleted;
  bool isFavourite;

  Task({required this.id, required this.title, this.isCompleted = false, this.isFavourite = false});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Category> _categories = [];
  final List<Task> _tasks = [];

  void _addCategory(String categoryName) {
    const uuid = Uuid();
    final newCategory = Category(id: uuid.v4(), name: categoryName);
    setState(() {
      _categories.add(newCategory);
    });
  }

  void _showAddCategoryDialog() {
  // Создайте контроллер для TextField
  final TextEditingController _controller = TextEditingController();
  showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder( 
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Добавить новую категорию'),
            content: TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {});
              },
              autofocus: true,
              maxLength: 40, 
              decoration: const InputDecoration(hintText: "Название категории"),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Отмена'),
              ),
              TextButton(
                onPressed: _controller.text.trim().isEmpty 
                    ? null
                    : () {
                        _addCategory(_controller.text.trim()); 
                        Navigator.pop(context, 'OK');
                      },
                child: const Text('Добавить'),
              ),
            ],
          );
        },
      );
    },
  );
}

  void _removeCategory(String id) {
    setState(() {
      _categories.removeWhere((category) => category.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _categories.isEmpty
          ? const Center(
              child: Text("Список категорий пуст",
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(9.0),
                  child: Text(
                    "Категории",
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  
                  child: ListView.builder(
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      return Dismissible(
                        key: Key(category.id),
                        onDismissed: (_) => _removeCategory(category.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                        
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: Card(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0), 
                          ),
                          child: ListTile(
                            title: Text(category.name),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => TasksPage(categoryName: category.name, tasks: _tasks)));
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCategoryDialog,
        tooltip: 'Добавить категорию',
        backgroundColor: const Color.fromARGB(255, 127, 224, 216),
        child: const Icon(Icons.add),
      ),
    );
  }
}


// ignore: must_be_immutable
class TasksPage extends StatefulWidget {
  final String categoryName;
  List<Task> tasks;
  TasksPage({super.key, required this.categoryName, required this.tasks});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  String _filterType = "Все";

  List<Task> get _filteredTasks {
    switch (_filterType) {
      case "Завершенные":
        return widget.tasks.where((task) => task.isCompleted).toList();
      case "Незавершенные":
        return widget.tasks.where((task) => !task.isCompleted).toList();
      case "Избранные":
        return widget.tasks.where((task) => task.isFavourite).toList();
      default:
        return widget.tasks;
    }
  }

  void _addTask(String taskTitle) {
    const uuid = Uuid();
    final newTask = Task(id: uuid.v4(), title: taskTitle);
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
            ) : 
          Column(
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
                  onDismissed: (_) => _removeTask(task.id),
                  direction: DismissDirection.endToStart,
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
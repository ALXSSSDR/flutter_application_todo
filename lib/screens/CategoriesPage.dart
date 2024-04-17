import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/category.dart';
import '../models/task.dart';
import 'TasksPage.dart';

class CategoriesPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const CategoriesPage({Key? key, required this.title});
  final String title;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
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
    final TextEditingController controller = TextEditingController();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Добавить новую категорию'),
              content: TextField(
                controller: controller,
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
                  onPressed: controller.text.trim().isEmpty
                      ? null
                      : () {
                          _addCategory(controller.text.trim());
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

  Future<void> _showEditCategoryDialog(Category category) async {
    final TextEditingController editController = TextEditingController(text: category.name);

    final String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Редактировать категорию'),
          content: TextField(
            controller: editController,
            autofocus: true,
            maxLength: 40,
            decoration: const InputDecoration(hintText: "Название категории"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: editController.text.trim().isEmpty
                  ? null
                  : () {
                      Navigator.pop(context, 'updated');
                    },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );

    if (result == 'updated') {
      setState(() {
        int index = _categories.indexWhere((cat) => cat.id == category.id);
        if (index != -1) {
          _categories[index].name = editController.text.trim();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _categories.isEmpty
          ? const Center(
              child: Text("Список категорий пуст", style: TextStyle(fontSize: 18)),
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
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            _removeCategory(category.id);
                          }
                        },
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            await _showEditCategoryDialog(category);
                            return false;
                          }
                          return true;
                        },
                        background: Container(
                          color: Colors.yellow,
                          margin: const EdgeInsets.only(top: 10),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20.0),
                          child: const Icon(Icons.edit, color: Colors.white),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          margin: const EdgeInsets.only(top: 10),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.horizontal,
                        child: Card(
                          margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: ListTile(
                            title: Text(category.name),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => TasksPage(categoryName: category.name, categoryId: category.id, tasks: _tasks)));
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



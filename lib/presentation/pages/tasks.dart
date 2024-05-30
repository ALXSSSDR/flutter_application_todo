import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/domain/entities/category.dart';
import 'package:flutter_application_1/presentation/widgets/task/add.dart';
import 'package:flutter_application_1/presentation/widgets/task/list.dart';
import 'package:flutter_application_1/presentation/widgets/task/set_filter.dart';

class TaskListPage extends ConsumerWidget {
  final CategoryEntity category;

  const TaskListPage({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(category.name),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => Filter(categoryId: category.id),
            ),
          ),
        ],
      ),
      body: TaskList(
        category: category,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) => TaskAddWidget(category: category),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          isScrollControlled: true,
          transitionAnimationController: AnimationController(
            vsync: Navigator.of(context),
            duration: const Duration(milliseconds: 300),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
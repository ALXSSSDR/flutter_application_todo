import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/presentation/widgets/category/add.dart';
import 'package:flutter_application_1/presentation/widgets/category/list.dart';

class CategoryListPage extends ConsumerWidget {
  const CategoryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Список категорий'),
      ),
      body: const CategoryList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) => const CategoryAddWidget(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          isScrollControlled: true,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entities/category.dart';
import 'package:flutter_application_1/presentation/pages/tasks.dart';

void openTaskListPage(CategoryEntity category, BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => TaskListPage(category: category),
    ),
  );
}
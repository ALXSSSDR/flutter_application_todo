import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/core/navigation/navigator.dart';
import 'package:flutter_application_1/core/provider/bloc.dart';
import 'package:flutter_application_1/domain/entities/category.dart';
import 'package:flutter_application_1/presentation/widgets/category/edit.dart';
import 'package:flutter_application_1/presentation/widgets/delete_confirmation.dart';

class CategoryItemWidget extends ConsumerWidget {
  final CategoryEntity category;

  const CategoryItemWidget({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = ref.watch(categoryListBlocProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Dismissible(
          key: ValueKey(category.id),
          background: Container(
            color: Colors.blue,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.edit, color: Colors.white),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              showModalBottomSheet(
                context: context,
                builder: (context) => CategoryEditWidget(
                  categoryName: category.name,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                isScrollControlled: true,
              );
              return false;
            } else if (direction == DismissDirection.endToStart) {
              final bool? confirmDelete = await showDialog(
                context: context,
                builder: (_) => ConfirmationDeleteDialog(
                  delFunc: bloc.removeCategory,
                  objId: category.id,
                ),
              );
              return confirmDelete == true;
            }
            return false;
          },
          child: Container(
            color: Colors.grey[200],
            child: ListTile(
              title: Text(category.name),
              leading: const Icon(Icons.list),
              onTap: () => openTaskListPage(category, context),
            ),
          ),
        ),
      ),
    );
  }
}

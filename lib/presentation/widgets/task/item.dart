import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/core/provider/bloc.dart';
import 'package:flutter_application_1/domain/entities/task.dart';
import 'package:flutter_application_1/presentation/widgets/delete_confirmation.dart';
import 'package:flutter_application_1/presentation/widgets/task/edit.dart';

class TaskItemWidget extends ConsumerWidget {
  final TaskEntity task;

  const TaskItemWidget({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = ref.watch(taskListBlocProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Dismissible(
          key: Key(task.id),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20.0),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) => bloc.removeTask(task.id),
          confirmDismiss: (direction) async {
            return showDialog(
              context: context,
              builder: (_) => ConfirmationDeleteDialog(
                delFunc: bloc.removeTask,
                objId: task.id,
              ),
            );
          },
          child: Container(
            color: Colors.grey[200],
            child: ListTile(
              title: Text(
                task.name,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: task.description.isEmpty
                  ? null
                  : Text(
                      task.description,
                      overflow: TextOverflow.ellipsis,
                    ),
              onTap: () => openTaskScreen(context, task),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: task.isFavourite
                        ? const Icon(Icons.star)
                        : const Icon(Icons.star_border),
                    onPressed: () {
                      task.isFavourite
                          ? bloc.favourTask(task.id, false)
                          : bloc.favourTask(task.id, true);
                      bloc.refresh(task.categoryId);
                    },
                  ),
                  IconButton(
                    icon: task.isCompleted
                        ? const Icon(Icons.circle)
                        : const Icon(Icons.circle_outlined),
                    onPressed: () {
                      task.isCompleted
                          ? bloc.completeTask(task.id, false)
                          : bloc.completeTask(task.id, true);
                      bloc.refresh(task.categoryId);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void openTaskScreen(BuildContext context, TaskEntity task) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      builder: (_) => TaskEditWidget(task: task),
      useSafeArea: true,
      isScrollControlled: true,
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: const Duration(milliseconds: 300),
      ),
    );
  }
}

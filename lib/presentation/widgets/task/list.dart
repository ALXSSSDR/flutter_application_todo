import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_application_1/core/provider/bloc.dart';
import 'package:flutter_application_1/domain/entities/category.dart';
import 'package:flutter_application_1/presentation/states/task/list/bloc.dart';
import 'package:flutter_application_1/presentation/states/task/list/state.dart';
import 'package:flutter_application_1/presentation/widgets/task/item.dart';

class TaskList extends HookConsumerWidget {
  final CategoryEntity category;

  const TaskList({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = ref.watch(taskListBlocProvider);

    useEffect(() {
      bloc.refresh(category.id);
      return null;
    });

      return BlocBuilder<TaskListBloc, TaskListState>(
      bloc: bloc,
      builder: (_, state) {
        if (state is Loading) {
          bloc.refresh(category.id);
          return const Center(child: CircularProgressIndicator());
        } else if (state is Data) {
          return RefreshIndicator(
            onRefresh: () => bloc.refresh(category.id),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (state.data.isEmpty) {
                  return ListView(
                    children: [
                      SizedBox(
                        height: constraints.maxHeight - 20,
                        child: const Center(
                          child: Text('нет задач'),
                        ),
                      ),
                    ],
                  );
                }
                return ListView(
                  children: state.data
                      .map((task) => TaskItemWidget(task: task))
                      .toList(),
                );
              },
            ),
          );
        } else if (state is Error) {
          return Center(child: Text(state.msg));
        } else {
          return Container(); 
        }
      },
    );

  }
}
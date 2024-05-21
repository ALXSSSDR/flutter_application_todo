import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/core/provider/bloc.dart';
import 'package:flutter_application_1/data/models/filter.dart';
import 'package:flutter_application_1/domain/entities/filter.dart';
import 'package:flutter_application_1/presentation/states/filter/bloc.dart';
import 'package:flutter_application_1/presentation/states/filter/state.dart';

class Filter extends ConsumerWidget {
  final String categoryId;

  const Filter({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = ref.watch(filterListBlocProvider);
    bloc.refresh(categoryId);

    return BlocBuilder<FilterListBloc, FilterListState>(
      bloc: bloc,
      builder: (_, state) {
        if (state is Loading) {
          bloc.refresh(categoryId);
          return const Center(child: CircularProgressIndicator());
        } else if (state is Data) {
          return AlertDialog(
            title: const Text(
              'Установить фильтр',
              style: TextStyle(fontSize: 20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: filtersMap.entries.map((entry) {
                return RadioListTile<FilterStatus>(
                  title: Text(entry.value),
                  value: entry.key,
                  groupValue: state.data,
                  onChanged: (value) {
                    bloc.setFilter(categoryId, value!);
                    bloc.refresh(categoryId);
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
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
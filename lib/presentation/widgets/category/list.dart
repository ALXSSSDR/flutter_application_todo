import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_application_1/core/provider/bloc.dart';
import 'package:flutter_application_1/presentation/states/category/list/bloc.dart';
import 'package:flutter_application_1/presentation/states/category/list/state.dart';
import 'package:flutter_application_1/presentation/widgets/category/item.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = ref.watch(categoryListBlocProvider);
    return BlocBuilder<CategoryListBloc, CategoryListState>(
      bloc: bloc,
      builder: (_, state) {
  if (state is Loading) {
    bloc.refresh();
    return const Center(child: CircularProgressIndicator());
  } else if (state is Data) {
    return RefreshIndicator(
      onRefresh: bloc.refresh,
      child: Builder(
        builder: (context) {
          if (state.data.isEmpty) {
            return const Center(
              child: Text('нет категорий'),
            );
          }
          return ListView(
            children: state.data
                .map((category) => CategoryItemWidget(category: category))
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
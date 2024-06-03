import 'package:flutter_application_1/data/models/filter.dart';

class FilterEntity {
  final FilterStatus name;
  final String categoryId;

  const FilterEntity({required this.name, required this.categoryId});
}

final Map<FilterStatus, String> filtersMap = {
  FilterStatus.all: 'Все задачи',
  FilterStatus.completed: 'Выполненные',
  FilterStatus.uncompleted: 'Не выполненные',
  FilterStatus.favourite: 'Избранные',
};




import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/data/datasources/db.dart';

final dbProvider = Provider<AppDatabase>((ref) {
  return AppDatabase(); 
});
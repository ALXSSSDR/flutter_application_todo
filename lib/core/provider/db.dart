import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/data/datasources/db.dart';
import 'package:dio/dio.dart';


final dbProvider = Provider<AppDatabase>((ref) {
  return AppDatabase(); 
});

final dioProvider = Provider(
  (_) => Dio(),
);
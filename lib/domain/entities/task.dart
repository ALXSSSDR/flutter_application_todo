import 'package:flutter_application_1/domain/entities/image.dart';

class TaskEntity {
  final String id;
  final String name;
  final DateTime createdAt;
  final String description;
  final bool isCompleted;
  final bool isFavourite;
  final List<ImgEntity> imgUrls;
  final String categoryId;

  const TaskEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.description,
    this.isCompleted = false,
    this.isFavourite = false,
    this.imgUrls = const [],
    required this.categoryId,
  });

  TaskEntity copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    String? description,
    bool? isCompleted,
    bool? isFavourite,
    List<ImgEntity>? imgUrls,
    String? categoryId,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isFavourite: isFavourite ?? this.isFavourite,
      imgUrls: imgUrls ?? this.imgUrls,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}
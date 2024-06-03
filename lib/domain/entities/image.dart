
class ImgEntity {
  final String id;
  final String url;
  final String taskId;

  const ImgEntity({
    required this.id,
    required this.url,
    required this.taskId,
  });

  ImgEntity copyWith({
    String? id,
    String? url,
    String? taskId,
  }) {
    return ImgEntity(
      id: id ?? this.id,
      url: url ?? this.url,
      taskId: taskId ?? this.taskId,
    );
  }
}

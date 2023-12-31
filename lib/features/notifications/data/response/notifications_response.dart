class NotificationsResponse {
  NotificationsResponse({
    required this.data,
  });

  final List<NotificationModel> data;

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsResponse(
      data: json["data"] == null
          ? []
          : List<NotificationModel>.from(
              json["data"]!.map((x) => NotificationModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class NotificationModel {
  NotificationModel({
    required this.id,
    required this.message,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String message;
  final String type;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"] ?? 0,
      message: json["message"] ?? "",
      type: json["type"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  factory NotificationModel.initial() {
    return NotificationModel(
      id: 1,
      message: 'اختبار الاشعار',
      type: 'temp',
      createdAt: DateTime.now(),
      updatedAt: null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "type": type,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

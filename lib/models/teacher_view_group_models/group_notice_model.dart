class GroupNoticeModel {
  String? status;
  String? message;
  Response? response;

  GroupNoticeModel({
    this.status,
    this.message,
    this.response,
  });

  factory GroupNoticeModel.fromJson(Map<String, dynamic> json) => GroupNoticeModel(
        status: json["status"],
        message: json["message"],
        response: Response.fromJson(json["response"]),
      );
}

class Response {
  String? noticeId;
  String? title;
  String? description;
  int? updatedAt;

  Response({
    this.noticeId,
    this.title,
    this.description,
    this.updatedAt,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        noticeId: json["notice_id"],
        title: json["title"],
        description: json["description"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "notice_id": noticeId,
        "title": title,
        "description": description,
        "updated_at": updatedAt,
      };
}

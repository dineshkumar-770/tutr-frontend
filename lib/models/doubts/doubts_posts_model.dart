class DoubtPostsModel {
  String? status;
  String? message;
  List<DoubetPost>? response;

  DoubtPostsModel({
    this.status,
    this.message,
    this.response,
  });

  factory DoubtPostsModel.fromJson(Map<String, dynamic> json) => DoubtPostsModel(
        status: json["status"],
        message: json["message"],
        response:
            json["response"] == null ? [] : List<DoubetPost>.from(json["response"].map((x) => DoubetPost.fromJson(x))),
      );
}

class DoubetPost {
  String? doubtId;
  String? groupId;
  String? studentId;
  String? teacherId;
  String? doubtText;
  List<AttachedFile>? attachedFiles;
  String? status;
  int? createdAt;
  int? updatedAt;
  String? fullName;
  String? studentEmail;
  String? studentClass;

  DoubetPost({
    this.doubtId,
    this.groupId,
    this.studentId,
    this.teacherId,
    this.doubtText,
    this.attachedFiles,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.fullName,
    this.studentEmail,
    this.studentClass,
  });

  factory DoubetPost.fromJson(Map<String, dynamic> json) => DoubetPost(
        doubtId: json["doubt_id"],
        groupId: json["group_id"],
        studentId: json["student_id"],
        teacherId: json["teacher_id"],
        doubtText: json["doubt_text"],
        attachedFiles: json["attached_files"] == null
            ? []
            : List<AttachedFile>.from(json["attached_files"].map((x) => AttachedFile.fromJson(x))),
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        fullName: json["full_name"],
        studentEmail: json["student_email"],
        studentClass: json["student_class"],
      );
}

class AttachedFile {
  String? noteUrl;
  String? fileName;

  AttachedFile({
    this.noteUrl,
    this.fileName,
  });

  factory AttachedFile.fromJson(Map<String, dynamic> json) => AttachedFile(
        noteUrl: json["note_url"],
        fileName: json["file_name"],
      );
}

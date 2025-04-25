class GroupNotesMaterialModel {
  String? status;
  String? message;
  List<StudyMaterial>? response;

  GroupNotesMaterialModel({
    this.status,
    this.message,
    this.response,
  });

  factory GroupNotesMaterialModel.fromJson(Map<String, dynamic> json) => GroupNotesMaterialModel(
        status: json["status"],
        message: json["message"],
        response: json["response"] == null
            ? []
            : List<StudyMaterial>.from(json["response"].map((x) => StudyMaterial.fromJson(x))),
      );
}

class StudyMaterial {
  String? notesId;
  String? notesTitle;
  String? notesDesctription;
  String? className;
  String? notesTopic;
  String? notesSubject;
  int? uploadedAt;
  List<AttachedFile>? attachedFiles;
  String? notesVisiblity;
  bool? isEditable;

  StudyMaterial({
    this.notesId,
    this.notesTitle,
    this.notesDesctription,
    this.className,
    this.notesTopic,
    this.notesSubject,
    this.uploadedAt,
    this.attachedFiles,
    this.notesVisiblity,
    this.isEditable,
  });

  factory StudyMaterial.fromJson(Map<String, dynamic> json) => StudyMaterial(
        notesId: json["notes_id"],
        notesTitle: json["notes_title"],
        notesDesctription: json["notes_desctription"],
        className: json["class_name"],
        notesTopic: json["notes_topic"],
        notesSubject: json["notes_subject"],
        uploadedAt: json["uploaded_at"],
        attachedFiles: json["attached_files"] == null ? [] :  List<AttachedFile>.from(json["attached_files"].map((x) => AttachedFile.fromJson(x))),
        notesVisiblity: json["notes_visiblity"],
        isEditable: json["is_editable"],
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

    Map<String, dynamic> toJson() => {
        "note_url": noteUrl,
        "file_name": fileName,
    };
}
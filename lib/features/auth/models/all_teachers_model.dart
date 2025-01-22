class AllTeachersModel {
  String? status;
  String? message;
  List<TeachersData> response;

  AllTeachersModel({
    this.status,
    this.message,
    required this.response,
  });

  factory AllTeachersModel.fromJson(Map<String, dynamic> json) => AllTeachersModel(
        status: json["status"],
        message: json["message"],
        response: json["response"] != null && json["response"].isNotEmpty
            ? List<TeachersData>.from(json["response"].map((x) => TeachersData.fromJson(x)))
            : [],
      );
}

class TeachersData {
  String? teacherId;
  String? fullName;
  String? email;
  String? subject;
  int? contactNumber;
  int? createdAt;
  String? qualification;
  int? experienceYears;
  String? address;
  String? classAssigned;
  String? teacherCode;

  TeachersData({
    this.teacherId,
    this.fullName,
    this.email,
    this.contactNumber,
    this.subject,
    this.createdAt,
    this.qualification,
    this.experienceYears,
    this.address,
    this.classAssigned,
    this.teacherCode,
  });

  factory TeachersData.fromJson(Map<String, dynamic> json) => TeachersData(
        teacherId: json["teacher_id"],
        fullName: json["full_name"],
        email: json["email"],
        contactNumber: json["contact_number"],
        subject: json["subject"],
        createdAt: json["created_at"],
        qualification: json["qualification"],
        experienceYears: json["experience_years"],
        address: json["address"],
        classAssigned: json["class_assigned"],
        teacherCode: json["teacher_code"],
      );
}

class TeacherDataModel {
  String? status;
  String? message;
  Response? response;

  TeacherDataModel({
    this.status,
    this.message,
    this.response,
  });

  factory TeacherDataModel.fromJson(Map<String, dynamic> json) => TeacherDataModel(
        status: json["status"],
        message: json["message"],
        response: Response.fromJson(json["response"]),
      );
}

class Response {
  String? teacherId;
  String? fullName;
  String? email;
  int? contactNumber;
  String? subject;
  int? createdAt;
  String? qualification;
  int? experienceYears;
  String? address;
  String? classAssigned;
  String? teacherCode;

  Response({
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

  factory Response.fromJson(Map<String, dynamic> json) => Response(
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

  Map<String, dynamic> toJson() => {
        "teacher_id": teacherId,
        "full_name": fullName,
        "email": email,
        "contact_number": contactNumber,
        "subject": subject,
        "created_at": createdAt,
        "qualification": qualification,
        "experience_years": experienceYears,
        "address": address,
        "class_assigned": classAssigned,
        "teacher_code": teacherCode,
      };
}

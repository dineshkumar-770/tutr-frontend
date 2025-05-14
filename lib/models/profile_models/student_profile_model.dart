class StudentProfileModel {
  String? status;
  String? message;
  StudnetProfile? response;

  StudentProfileModel({
    this.status,
    this.message,
    this.response,
  });

  factory StudentProfileModel.fromJson(Map<String, dynamic> json) => StudentProfileModel(
        status: json["status"],
        message: json["message"],
        response: StudnetProfile.fromJson(json["response"]),
      );
}

class StudnetProfile {
  String? studentId;
  String? fullName;
  String? email;
  int? createdAt;
  int? contactNumber;
  String? responseClass;
  int? parentsContact;
  String? fullAddress;

  StudnetProfile({
    this.studentId,
    this.fullName,
    this.email,
    this.createdAt,
    this.contactNumber,
    this.responseClass,
    this.parentsContact,
    this.fullAddress,
  });

  factory StudnetProfile.fromJson(Map<String, dynamic> json) => StudnetProfile(
        studentId: json["student_id"],
        fullName: json["full_name"],
        email: json["email"],
        createdAt: json["created_at"],
        contactNumber: json["contact_number"],
        responseClass: json["class"],
        parentsContact: json["parents_contact"],
        fullAddress: json["full_address"],
      );
}

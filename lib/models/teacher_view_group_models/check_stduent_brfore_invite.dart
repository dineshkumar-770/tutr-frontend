 
class CheckStudentBeforeInviteModel {
  String? status;
  String? message;
  StudentData? response;

  CheckStudentBeforeInviteModel({
    this.status,
    this.message,
    this.response,
  });

  factory CheckStudentBeforeInviteModel.fromJson(Map<String, dynamic> json) => CheckStudentBeforeInviteModel(
        status: json["status"],
        message: json["message"],
        response: StudentData.fromJson(json["response"]),
      );
}

class StudentData {
  String? studentId;
  String? fullName;
  String? email;
  int? createdAt;
  int? contactNumber;
  String? responseClass;
  int? parentsContact;
  String? fullAddress;

  StudentData({
    this.studentId,
    this.fullName,
    this.email,
    this.createdAt,
    this.contactNumber,
    this.responseClass,
    this.parentsContact,
    this.fullAddress,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) => StudentData(
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

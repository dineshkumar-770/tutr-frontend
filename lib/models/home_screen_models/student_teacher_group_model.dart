class StudentTeacherGroupModel {
  String? status;
  String? message;
  List<Response>? response;

  StudentTeacherGroupModel({
    this.status,
    this.message,
    this.response,
  });

  factory StudentTeacherGroupModel.fromJson(Map<String, dynamic> json) => StudentTeacherGroupModel(
        status: json["status"],
        message: json["message"],
        response:
            json["response"] == null ? [] : List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
      );
}

class Response {
  String? groupId;
  String? studentId;
  int? createdAt;
  String? groupClass;
  String? groupName;
  String? groupDescription;
  TeacherDetails? teacherDetails;
  List<GroupMember>? groupMembers;

  Response({
    this.groupId,
    this.studentId,
    this.createdAt,
    this.groupClass,
    this.groupName,
    this.groupDescription,
    this.teacherDetails,
    this.groupMembers,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        groupId: json["group_id"],
        studentId: json["student_id"],
        createdAt: json["created_at"],
        groupClass: json["group_class"],
        groupName: json["group_name"],
        groupDescription: json["group_description"],
        teacherDetails: TeacherDetails.fromJson(json["teacher_details"]),
        groupMembers: json["group_members"] == null
            ? []
            : List<GroupMember>.from(json["group_members"].map((x) => GroupMember.fromJson(x))),
      );
}

class GroupMember {
  String? groupMemberId;
  String? groupId;
  String? groupOwnerName;
  int? studentJoinedAt;
  String? studentFullName;
  String? studentClass;

  GroupMember({
    this.groupMemberId,
    this.groupId,
    this.groupOwnerName,
    this.studentJoinedAt,
    this.studentFullName,
    this.studentClass,
  });

  factory GroupMember.fromJson(Map<String, dynamic> json) => GroupMember(
        groupMemberId: json["group_member_id"],
        groupId: json["group_id"],
        groupOwnerName: json["group_owner_name"],
        studentJoinedAt: json["student_joined_at"],
        studentFullName: json["student_full_name"],
        studentClass: json["student_class"],
      );
}

class TeacherDetails {
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

  TeacherDetails({
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

  factory TeacherDetails.fromJson(Map<String, dynamic> json) => TeacherDetails(
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

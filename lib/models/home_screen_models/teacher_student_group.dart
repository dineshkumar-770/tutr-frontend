class TeacherStudentGroupModel {
  String? status;
  String? message;
  List<Response>? response;

  TeacherStudentGroupModel({
    this.status,
    this.message,
    this.response,
  });

  factory TeacherStudentGroupModel.fromJson(Map<String, dynamic> json) => TeacherStudentGroupModel(
        status: json["status"],
        message: json["message"],
        response:
            json["response"] == null ? [] : List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
      );
}

class Response {
  String? groupId;
  String? teacherId;
  int? createdAt;
  String? groupClass;
  String? groupName;
  String? groupDesc;
  List<AllMember>? allMembers;

  Response({
    this.groupId,
    this.teacherId,
    this.createdAt,
    this.groupClass,
    this.groupName,
    this.groupDesc,
    this.allMembers,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        groupId: json["group_id"],
        teacherId: json["teacher_id"],
        createdAt: json["created_at"],
        groupClass: json["group_class"],
        groupName: json["group_name"],
        groupDesc: json["group_desc"],
        allMembers: json["all_members"] == null
            ? []
            : List<AllMember>.from(json["all_members"].map((x) => AllMember.fromJson(x))),
      );
}

class AllMember {
  String? groupMemberId;
  String? groupId;
  String? studentId;
  String? ownerId;
  String? groupOwnerName;
  int? studentJoinedAt;
  String? studentFullName;
  String? studentEmail;
  int? studentAccountCreationDate;
  int? studentContact;
  String? studentClass;
  int? studentParnetsContact;
  String? studentFullAddress;

  AllMember({
    this.groupMemberId,
    this.groupId,
    this.studentId,
    this.ownerId,
    this.groupOwnerName,
    this.studentJoinedAt,
    this.studentFullName,
    this.studentEmail,
    this.studentAccountCreationDate,
    this.studentContact,
    this.studentClass,
    this.studentParnetsContact,
    this.studentFullAddress,
  });

  factory AllMember.fromJson(Map<String, dynamic> json) => AllMember(
        groupMemberId: json["group_member_id"],
        groupId: json["group_id"],
        studentId: json["student_id"],
        ownerId: json["owner_id"],
        groupOwnerName: json["group_owner_name"],
        studentJoinedAt: json["student_joined_at"],
        studentFullName: json["student_full_name"],
        studentEmail: json["student_email"],
        studentAccountCreationDate: json["student_account_creation_date"],
        studentContact: json["student_contact"],
        studentClass: json["student_class"],
        studentParnetsContact: json["student_parnets_contact"],
        studentFullAddress: json["student_full_address"],
      );

  Map<String, dynamic> toJson() => {
        "group_member_id": groupMemberId,
        "group_id": groupId,
        "student_id": studentId,
        "owner_id": ownerId,
        "group_owner_name": groupOwnerName,
        "student_joined_at": studentJoinedAt,
        "student_full_name": studentFullName,
        "student_email": studentEmail,
        "student_account_creation_date": studentAccountCreationDate,
        "student_contact": studentContact,
        "student_class": studentClass,
        "student_parnets_contact": studentParnetsContact,
        "student_full_address": studentFullAddress,
      };
}

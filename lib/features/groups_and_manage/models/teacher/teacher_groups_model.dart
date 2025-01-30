class TeacherGroupsModel {
  String? status;
  String? message;
  List<Response>? response;

  TeacherGroupsModel({
    this.status,
    this.message,
    this.response,
  });

  factory TeacherGroupsModel.fromJson(Map<String, dynamic> json) => TeacherGroupsModel(
        status: json["status"],
        message: json["message"],
        response: json["response"] == null ? [] : List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
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
        allMembers:
            json["all_members"] == null ? [] : List<AllMember>.from(json["all_members"].map((x) => AllMember.fromJson(x))),
      );
}

class AllMember {
  String? groupMemberId;
  String? groupId;
  String? studentId;
  String? ownerId;
  String? groupOwnerName;
  String? studentFullName;
  String? studentEmail;
  String? studentClass;
  String? studentFullAddress;
  int? studentJoinedAt;
  int? studentAccountCreationDate;
  int? studentContact;
  int? studentParnetsContact;

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
}

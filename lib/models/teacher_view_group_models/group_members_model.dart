class GroupMemberModel {
  String? status;
  String? message;
  List<GroupMember>? response;

  GroupMemberModel({
    this.status,
    this.message,
    this.response,
  });

  factory GroupMemberModel.fromJson(Map<String, dynamic> json) => GroupMemberModel(
        status: json["status"],
        message: json["message"],
        response: json["response"] == null
            ? []
            : List<GroupMember>.from(json["response"].map((x) => GroupMember.fromJson(x))),
      );
}

class GroupMember {
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

  GroupMember({
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

  factory GroupMember.fromJson(Map<String, dynamic> json) => GroupMember(
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

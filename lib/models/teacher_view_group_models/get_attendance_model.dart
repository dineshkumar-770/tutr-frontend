// ignore_for_file: constant_identifier_names

class GetAttendanceRecordsModel {
  String? status;
  String? message;
  List<AttendanceRecords>? response;

  GetAttendanceRecordsModel({
    this.status,
    this.message,
    this.response,
  });

  factory GetAttendanceRecordsModel.fromJson(Map<String, dynamic> json) => GetAttendanceRecordsModel(
        status: json["status"],
        message: json["message"],
        response: json["response"] == null
            ? []
            : List<AttendanceRecords>.from(json["response"].map((x) => AttendanceRecords.fromJson(x))),
      );
}

class AttendanceRecords {
  String? timestamp;
  String? attendanceId;
  int? presentStudents;
  int? absentStudents;
  int? totalStudents;
  int? leaveStudents;
  int? lateStudents;
  String? remarks;
  String? teacherId;
  String? groupId;
  List<Attendance>? attendance;

  AttendanceRecords({
    this.timestamp,
    this.attendanceId,
    this.presentStudents,
    this.absentStudents,
    this.totalStudents,
    this.leaveStudents,
    this.lateStudents,
    this.remarks,
    this.teacherId,
    this.groupId,
    this.attendance,
  });

  factory AttendanceRecords.fromJson(Map<String, dynamic> json) => AttendanceRecords(
        timestamp: json["timestamp"],
        attendanceId: json["attendance_id"],
        presentStudents: json["present_students"],
        absentStudents: json["absent_students"],
        totalStudents: json["total_students"],
        leaveStudents: json["leave_students"],
        lateStudents: json["late_students"],
        remarks: json["remarks"],
        teacherId: json["teacher_id"],
        groupId: json["group_id"],
        attendance: json["attendance"] == null
            ? []
            : List<Attendance>.from(json["attendance"].map((x) => Attendance.fromJson(x))),
      );
}

class Attendance {
  String? studentId;
  Status? status;
  String? name;
  String? stEmail;
  int? studentPhone;

  Attendance({
    this.studentId,
    this.status,
    this.name,
    this.stEmail,
    this.studentPhone,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        studentId: json["student_id"],
        status: statusValues.map[json["status"]],
        name: json["name"],
        stEmail: json["st_email"],
        studentPhone: json["student_phone"],
      );
}

enum Status { ABSENT, LATE, LEAVE, PRESENT }

final statusValues =
    EnumValues({"absent": Status.ABSENT, "late": Status.LATE, "leave": Status.LEAVE, "present": Status.PRESENT});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

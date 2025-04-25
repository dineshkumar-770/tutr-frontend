class GetAttendanceModel {
  String? status;
  String? message;
  List<AttResponse>? response;

  GetAttendanceModel({
    this.status,
    this.message,
    this.response,
  });

  factory GetAttendanceModel.fromJson(Map<String, dynamic> json) => GetAttendanceModel(
        status: json["status"],
        message: json["message"],
        response: json["response"] == null
            ? []
            : List<AttResponse>.from(json["response"].map((x) => AttResponse.fromJson(x))),
      );
}

class AttResponse {
  String? attendanceId;
  String? teacherId;
  String? groupId;
  int? presentStudent;
  int? totalStudents;
  int? absentStudents;
  String? markedAttendance;
  int? createdAt;
  String? remarks;
  int? isMarkedSuccess;

  AttResponse({
    this.attendanceId,
    this.teacherId,
    this.groupId,
    this.presentStudent,
    this.totalStudents,
    this.absentStudents,
    this.markedAttendance,
    this.createdAt,
    this.remarks,
    this.isMarkedSuccess,
  });

  factory AttResponse.fromJson(Map<String, dynamic> json) => AttResponse(
        attendanceId: json["attendance_id"],
        teacherId: json["teacher_id"],
        groupId: json["group_id"],
        presentStudent: json["present_student"],
        totalStudents: json["total_students"],
        absentStudents: json["absent_students"],
        markedAttendance: json["marked_attendance"],
        createdAt: json["created_at"],
        remarks: json["remarks"],
        isMarkedSuccess: json["is_marked_success"],
      );

  Map<String, dynamic> toJson() => {
        "attendance_id": attendanceId,
        "teacher_id": teacherId,
        "group_id": groupId,
        "present_student": presentStudent,
        "total_students": totalStudents,
        "absent_students": absentStudents,
        "marked_attendance": markedAttendance,
        "created_at": createdAt,
        "remarks": remarks,
        "is_marked_success": isMarkedSuccess,
      };
}


class StudentAttendance {
  final String name;
  final String status;
  final String email;
  final String studentId;
  final int phone;

  StudentAttendance({
    required this.name,
    required this.status,
    required this.email,
    required this.studentId,
    required this.phone,
  });

  factory StudentAttendance.fromJson(Map<String, dynamic> json) {
    return StudentAttendance(
      name: json['name'],
      status: json['status'],
      email: json['st_email'],
      studentId: json['student_id'],
      phone: json['student_phone'],
    );
  }
}
// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'teacher_view_group_bloc.dart';

class TeacherViewGroupEvent extends Equatable {
  const TeacherViewGroupEvent();

  @override
  List<Object> get props => [];
}

class CreateNoticeForGroupEvent extends TeacherViewGroupEvent {
  final String groupId;
  final String title;
  final String description;
  final BuildContext context;

  const CreateNoticeForGroupEvent({
    required this.groupId,
    required this.title,
    required this.description,
    required this.context,
  });
  @override
  List<Object> get props => [groupId, description, title, context];
}

class FetchNoticeForGroupEvent extends TeacherViewGroupEvent {
  final String groupId;
  final BuildContext context;

  const FetchNoticeForGroupEvent({
    required this.groupId,
    required this.context,
  });
  @override
  List<Object> get props => [groupId, context];
}

class UpdateNoticeBoardEvent extends TeacherViewGroupEvent {
  final String groupId;
  final String noticeTitle;
  final String noticeDesc;
  final String noticeId;
  final BuildContext context;

  const UpdateNoticeBoardEvent(
      {required this.groupId,
      required this.noticeTitle,
      required this.noticeDesc,
      required this.noticeId,
      required this.context});

  @override
  List<Object> get props => [
        groupId,
        noticeTitle,
        noticeDesc,
        noticeId,
        context,
      ];
}

class FetchGroupMembersEvent extends TeacherViewGroupEvent {
  final String groupId;
  final BuildContext context;
  final String ownerId;

  const FetchGroupMembersEvent({required this.groupId, required this.context, required this.ownerId});

  @override
  List<Object> get props => [groupId, context, ownerId];
}

class UploadClassMaterialEvent extends TeacherViewGroupEvent {}

class AttachClassMaterialEvent extends TeacherViewGroupEvent {
  final BuildContext context;

  const AttachClassMaterialEvent({required this.context});
  @override
  List<Object> get props => [
        context,
      ];
}

class UpdateAttachmentsEvent extends TeacherViewGroupEvent {
  final String selectedFilePath;

  const UpdateAttachmentsEvent({required this.selectedFilePath});

  @override
  List<Object> get props => [
        selectedFilePath,
      ];
}

class UploadGroupMaterialEvent extends TeacherViewGroupEvent {
  final String notesTitle;
  final String notesDescription;
  final String className;
  final String notesTopic;
  final String subject;
  final String visiblity;
  final String groupId;
  final String isEditable;
  final BuildContext context;
  final List<String> filePath;

  const UploadGroupMaterialEvent(
      {required this.notesTitle,
      required this.notesDescription,
      required this.className,
      required this.notesTopic,
      required this.subject,
      required this.visiblity,
      required this.groupId,
      required this.isEditable,
      required this.context,
      required this.filePath});

  @override
  List<Object> get props =>
      [notesTitle, notesDescription, className, notesTopic, subject, visiblity, groupId, isEditable, filePath, context];
}

class FetchGroupMaterialNotes extends TeacherViewGroupEvent {
  final String groupId;
  final BuildContext context;

  const FetchGroupMaterialNotes({required this.groupId, required this.context});
  @override
  List<Object> get props => [
        groupId,
        context,
      ];
}

class FetchuserContactsListEvent extends TeacherViewGroupEvent {
  final BuildContext context;

  const FetchuserContactsListEvent({required this.context});
  @override
  List<Object> get props => [context];
}

class DeleteClassMaterialEvent extends TeacherViewGroupEvent {
  final BuildContext context;
  final int selectedNotesIndex;
  final String notesId;
  final String groupId;
  final String notesTitle;
  final String reason;
  final String notesDescription;
  final String filesUrl;

  const DeleteClassMaterialEvent(
      {required this.context,
      required this.selectedNotesIndex,
      required this.notesId,
      required this.groupId,
      required this.notesTitle,
      required this.reason,
      required this.notesDescription,
      required this.filesUrl});

  @override
  List<Object> get props => [
        context,
        selectedNotesIndex,
        notesId,
        groupId,
        notesTitle,
        reason,
        notesDescription,
        filesUrl,
      ];
}

class CheckBeforeInviteStudentEvent extends TeacherViewGroupEvent {
  final BuildContext context;
  final String phoneNumber;
  final int tappedIndex;
  final String ownerName;
  final String groupId;
  final String className;

  const CheckBeforeInviteStudentEvent({
    required this.context,
    required this.phoneNumber,
    required this.tappedIndex,
    required this.ownerName,
    required this.groupId,
    required this.className,
  });

  @override
  List<Object> get props => [
        phoneNumber,
        context,
        tappedIndex,
        ownerName,
        groupId,
        className,
      ];
}

class SaveStudensAttendanceEvent extends TeacherViewGroupEvent {
  final List<Map<String, dynamic>> markedAttendanceList;
  final String groupId;
  final String remarks;
  final BuildContext context;

  const SaveStudensAttendanceEvent({
    required this.markedAttendanceList,
    required this.groupId,
    required this.remarks,
    required this.context,
  });

  @override
  List<Object> get props => [markedAttendanceList, groupId, remarks, context];
}

class MarkAttendanceEvent extends TeacherViewGroupEvent {
  final Map<String, dynamic> attendanceRecord;

  const MarkAttendanceEvent({required this.attendanceRecord});

  @override
  List<Object> get props => [attendanceRecord];
}

class GetAttendanceRecordsEvent extends TeacherViewGroupEvent {
  final String groupId;
  final int page;
  final int count;
  final String startDate;
  final String endDate;
  final String teacherId;
  final String? studentId;

  const GetAttendanceRecordsEvent(
      {required this.groupId,
      required this.page,
      required this.count,
      required this.startDate,
      required this.endDate,
      required this.teacherId,
      required this.studentId});
  @override
  List<Object> get props => [
        groupId,
        page,
        count,
        startDate,
        endDate,
        teacherId,
        studentId ?? "",
      ];
}

class OnSelectedDateEvent extends TeacherViewGroupEvent {
  final DateTime selectedDay;
  final DateTime focusedDay;

  const OnSelectedDateEvent({required this.selectedDay, required this.focusedDay});

  @override
  List<Object> get props => [selectedDay, focusedDay];
}

class UpdateBulkRecordsAttendance extends TeacherViewGroupEvent {
  final String attendanceId;
  final BuildContext context;
  final List<Map<String, dynamic>> updatedRecords;

  const UpdateBulkRecordsAttendance({
    required this.attendanceId,
    required this.context,
    required this.updatedRecords,
  });

  @override
  List<Object> get props => [attendanceId, updatedRecords, context];
}

class InitializeOriginalRecordsList extends TeacherViewGroupEvent {
  final List<Map<String, dynamic>> originalList;

  const InitializeOriginalRecordsList({required this.originalList});

  @override
  List<Object> get props => [originalList];
}

class GetDoubtPostsEvent extends TeacherViewGroupEvent {
  final String groupId;
  final String teacherId;

  const GetDoubtPostsEvent({required this.groupId, required this.teacherId});
  @override
  List<Object> get props => [groupId, teacherId];
}

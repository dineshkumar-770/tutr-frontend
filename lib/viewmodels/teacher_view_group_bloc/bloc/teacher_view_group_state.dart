// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'teacher_view_group_bloc.dart';

class TeacherViewGroupState extends Equatable {
  final bool createNoticeLoading;
  final String createNoticeError;
  final bool fetchNoticeLoading;
  final String fetchNoticError;
  final GroupNoticeModel groupNoticeData;
  final bool updateNoticeLoading;
  final String updateNoticeError;
  final bool fetchmembersLoading;
  final String fetchMembersError;
  final List<GroupMember> groupMembersList;
  final List<String> attachedFilePathsList;
  final bool uploadNotesLoading;
  final bool getGroupNotesLoading;
  final String groupNotesError;
  final List<StudyMaterial> groupNotesMaterialdata;
  final bool fetchUserConatcsLoading;
  final List<UserContactsData> userContactsData;
  final Map<String, int> letterIndexMapForContacts;
  final bool checkStudentInviteLoading;
  final String inviteErrorMsg;
  final CheckStudentBeforeInviteModel checkStudentBeforeInviteData;
  final int inviteTappedIndex;
  final bool deleteNotesLoading;
  final String deleteNotesError;
  final int deleteNotesIndex;
  final List<Map<String, dynamic>> markedAttendanceList;
  final String remarks;
  final bool saveAttendanceLoading;
  final String saveAttendanceError;
  final bool fetchAttendanceRecordsLoading;
  final GetAttendanceRecordsModel attendanceRecordsData;
  final String attendanceRecordError;
  final  Map<DateTime, CalenderViewModel> calenderData;
  final DateTime focusedDay;
  final DateTime? selectedDay;

  const TeacherViewGroupState({
    required this.createNoticeLoading,
    required this.createNoticeError,
    required this.fetchNoticeLoading,
    required this.fetchNoticError,
    required this.groupNoticeData,
    required this.updateNoticeLoading,
    required this.updateNoticeError,
    required this.fetchmembersLoading,
    required this.fetchMembersError,
    required this.groupMembersList,
    required this.attachedFilePathsList,
    required this.uploadNotesLoading,
    required this.getGroupNotesLoading,
    required this.groupNotesError,
    required this.groupNotesMaterialdata,
    required this.fetchUserConatcsLoading,
    required this.userContactsData,
    required this.letterIndexMapForContacts,
    required this.checkStudentInviteLoading,
    required this.inviteErrorMsg,
    required this.checkStudentBeforeInviteData,
    required this.inviteTappedIndex,
    required this.deleteNotesLoading,
    required this.deleteNotesError,
    required this.deleteNotesIndex,
    required this.markedAttendanceList,
    required this.remarks,
    required this.saveAttendanceLoading,
    required this.saveAttendanceError,
    required this.fetchAttendanceRecordsLoading,
    required this.attendanceRecordsData,
    required this.attendanceRecordError,
    required this.calenderData,
    required this.focusedDay,
    this.selectedDay,
  });

  factory TeacherViewGroupState.init() => TeacherViewGroupState(
      createNoticeLoading: false,
      createNoticeError: "",
      fetchNoticError: "",
      updateNoticeError: "",
      uploadNotesLoading: false,
      attendanceRecordError: "",
      attendanceRecordsData: GetAttendanceRecordsModel(),
      fetchAttendanceRecordsLoading: false,
      deleteNotesError: "",
      deleteNotesLoading: false,
      saveAttendanceError: "",
      calenderData: {},
      focusedDay: DateTime.now(),
      selectedDay: DateTime.now(),
      saveAttendanceLoading: false,
      inviteTappedIndex: 0,
      fetchMembersError: "",
      letterIndexMapForContacts: {},
      checkStudentBeforeInviteData: CheckStudentBeforeInviteModel(),
      checkStudentInviteLoading: false,
      inviteErrorMsg: "",
      fetchUserConatcsLoading: false,
      userContactsData: [],
      fetchmembersLoading: false,
      attachedFilePathsList: [],
      markedAttendanceList: [],
      remarks: "",
      getGroupNotesLoading: false,
      groupNotesError: "",
      groupNotesMaterialdata: [],
      groupMembersList: [],
      deleteNotesIndex: -1,
      updateNoticeLoading: false,
      fetchNoticeLoading: false,
      groupNoticeData: GroupNoticeModel());

  @override
  List<Object> get props => [
        createNoticeLoading,
        fetchUserConatcsLoading,
        createNoticeError,
        fetchNoticError,
        saveAttendanceLoading,
        saveAttendanceError,
        fetchNoticeLoading,
        groupNoticeData,
        deleteNotesError,
        letterIndexMapForContacts,
        attachedFilePathsList,
        userContactsData,
        deleteNotesIndex,
        updateNoticeLoading,
        updateNoticeError,
        groupMembersList,
        deleteNotesLoading,
        uploadNotesLoading,
        fetchMembersError,
        fetchmembersLoading,
        getGroupNotesLoading,
        groupNotesError,
        groupNotesMaterialdata,
        checkStudentInviteLoading,
        inviteErrorMsg,
        checkStudentBeforeInviteData,
        inviteTappedIndex,
        markedAttendanceList,
        remarks,
        fetchAttendanceRecordsLoading,
        attendanceRecordsData,
        attendanceRecordError,
      ];

  TeacherViewGroupState copyWith({
    bool? createNoticeLoading,
    String? createNoticeError,
    bool? fetchNoticeLoading,
    String? fetchNoticError,
    GroupNoticeModel? groupNoticeData,
    bool? updateNoticeLoading,
    String? updateNoticeError,
    bool? fetchmembersLoading,
    String? fetchMembersError,
    List<GroupMember>? groupMembersList,
    List<String>? attachedFilePathsList,
    bool? uploadNotesLoading,
    bool? getGroupNotesLoading,
    String? groupNotesError,
    List<StudyMaterial>? groupNotesMaterialdata,
    bool? fetchUserConatcsLoading,
    List<UserContactsData>? userContactsData,
    Map<String, int>? letterIndexMapForContacts,
    bool? checkStudentInviteLoading,
    String? inviteErrorMsg,
    CheckStudentBeforeInviteModel? checkStudentBeforeInviteData,
    int? inviteTappedIndex,
    bool? deleteNotesLoading,
    String? deleteNotesError,
    int? deleteNotesIndex,
    List<Map<String, dynamic>>? markedAttendanceList,
    String? remarks,
    bool? saveAttendanceLoading,
    String? saveAttendanceError,
    bool? fetchAttendanceRecordsLoading,
    GetAttendanceRecordsModel? attendanceRecordsData,
    String? attendanceRecordError,
    Map<DateTime, CalenderViewModel>? calenderData,
    DateTime? focusedDay,
    DateTime? selectedDay,
  }) {
    return TeacherViewGroupState(
      createNoticeLoading: createNoticeLoading ?? this.createNoticeLoading,
      createNoticeError: createNoticeError ?? this.createNoticeError,
      fetchNoticeLoading: fetchNoticeLoading ?? this.fetchNoticeLoading,
      fetchNoticError: fetchNoticError ?? this.fetchNoticError,
      groupNoticeData: groupNoticeData ?? this.groupNoticeData,
      updateNoticeLoading: updateNoticeLoading ?? this.updateNoticeLoading,
      updateNoticeError: updateNoticeError ?? this.updateNoticeError,
      fetchmembersLoading: fetchmembersLoading ?? this.fetchmembersLoading,
      fetchMembersError: fetchMembersError ?? this.fetchMembersError,
      groupMembersList: groupMembersList ?? this.groupMembersList,
      attachedFilePathsList: attachedFilePathsList ?? this.attachedFilePathsList,
      uploadNotesLoading: uploadNotesLoading ?? this.uploadNotesLoading,
      getGroupNotesLoading: getGroupNotesLoading ?? this.getGroupNotesLoading,
      groupNotesError: groupNotesError ?? this.groupNotesError,
      groupNotesMaterialdata: groupNotesMaterialdata ?? this.groupNotesMaterialdata,
      fetchUserConatcsLoading: fetchUserConatcsLoading ?? this.fetchUserConatcsLoading,
      userContactsData: userContactsData ?? this.userContactsData,
      letterIndexMapForContacts: letterIndexMapForContacts ?? this.letterIndexMapForContacts,
      checkStudentInviteLoading: checkStudentInviteLoading ?? this.checkStudentInviteLoading,
      inviteErrorMsg: inviteErrorMsg ?? this.inviteErrorMsg,
      checkStudentBeforeInviteData: checkStudentBeforeInviteData ?? this.checkStudentBeforeInviteData,
      inviteTappedIndex: inviteTappedIndex ?? this.inviteTappedIndex,
      deleteNotesLoading: deleteNotesLoading ?? this.deleteNotesLoading,
      deleteNotesError: deleteNotesError ?? this.deleteNotesError,
      deleteNotesIndex: deleteNotesIndex ?? this.deleteNotesIndex,
      markedAttendanceList: markedAttendanceList ?? this.markedAttendanceList,
      remarks: remarks ?? this.remarks,
      saveAttendanceLoading: saveAttendanceLoading ?? this.saveAttendanceLoading,
      saveAttendanceError: saveAttendanceError ?? this.saveAttendanceError,
      fetchAttendanceRecordsLoading: fetchAttendanceRecordsLoading ?? this.fetchAttendanceRecordsLoading,
      attendanceRecordsData: attendanceRecordsData ?? this.attendanceRecordsData,
      attendanceRecordError: attendanceRecordError ?? this.attendanceRecordError,
      calenderData: calenderData ?? this.calenderData,
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }
}

// ignore: constant_identifier_names
enum StudentAttendanceStatus { PRESENT, ABSENT, LATE, LEAVE }

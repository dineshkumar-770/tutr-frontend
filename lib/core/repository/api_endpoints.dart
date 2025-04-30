class ApiEndpoints {
  static String serverName = "Lo";
  static final String _baseURL = getServerUrl(serverName);
  static String registerStudent = "$_baseURL/register_student";
  static String registerTeacher = "$_baseURL/register_teacher";
  static String getAllTeachers = "$_baseURL/get_all_teachers";
  static String sendOTPEmail = "$_baseURL/send_otp_by_email";
  static String verifyOTP = "$_baseURL/verify_otp";
  static String getTeacherStudentGroups = "$_baseURL/get_teachers_student_groups";
  static String getUserProfile = "$_baseURL/get_user_profile";
  static String checkStudentExist = "$_baseURL/check_user_exist";
  static String addStudentToGroup = "$_baseURL/add_student_to_group";

  //attendance
  static String takeStudentAttendance = "$_baseURL/get_attendance_record";
  static String markAttendance = "$_baseURL/mark_attendance";
  static String editAttendanceRecord = "$_baseURL/edit_attendance_record";

  //groups
  static String createGroup = "$_baseURL/create_group";
  static String getGroupMembers = "$_baseURL/get_all_group_members_teacher";

  //Group Notices
  static String createGroupNotice = "$_baseURL/create_notice_for_group";
  static String getGroupNotice = "$_baseURL/get_group_notices";
  static String updateNotice = "$_baseURL/update_group_notice";

  //Group material/notes
  static String uploadGroupMaterial = "$_baseURL/save_teacher_note";
  static String getGroupMaterialNotes = "$_baseURL/get_all_notes_in_group";
  static String deleteGroupNotes = "$_baseURL/delete_notes";

  static String getServerUrl(String serverType) {
    if (serverType == "L") {
      return "https://tutr.co.in";
    } else if (serverType == "D") {
      return "http://3.110.40.130:8088";
    } else if (serverType == "Lo") {
      return "https://756e-160-191-74-141.ngrok-free.app";
    }
    return "";
  }
}

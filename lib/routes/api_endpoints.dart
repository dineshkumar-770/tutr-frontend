class ApiEndpoints {
  static final String _baseURL = "https://02ad-103-92-40-69.ngrok-free.app";
  static String registerStudent = "$_baseURL/register_student";
  static String registerTeacher = "$_baseURL/register_teacher";
  static String getAllTeachers = "$_baseURL/get_all_teachers";
  static String sendOTPEmail = "$_baseURL/send_otp_by_email";
  static String verifyOTP = "$_baseURL/verify_otp";
  static String getTeacherGroups = "$_baseURL/get_teachers_groups";
  static String createTeacherGroup = "$_baseURL/create_group";
  static String getGroupNotices = "$_baseURL/get_group_notices";
}

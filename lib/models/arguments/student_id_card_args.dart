class StudentIdCardArgs {
  final String name;
  final String id;
  final String parentsContact;
  final String phone;
  final String email;
  final String address;
  final String className;
  final int joinedAt;
  final String imageUrl;

  StudentIdCardArgs(
      {required this.name,
      required this.id,
      required this.parentsContact,
      required this.phone,
      required this.email,
      required this.address,
      required this.className,
      required this.joinedAt,
      required this.imageUrl});
}

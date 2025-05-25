import 'package:flutter/material.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/models/arguments/teacher_id_args.dart';
import 'package:tutr_frontend/utils/adeptiveness.dart';
import 'package:tutr_frontend/utils/helpers.dart';

class TeacherIDCardScreen extends StatelessWidget {
  const TeacherIDCardScreen({super.key, required this.teacherIdArgs});
  final TeacherIdArgs teacherIdArgs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          double cardWidth = maxWidth * 0.85;
          double cardHeight = cardWidth * 1.6;
          double profileRadius = cardHeight * 0.08;

          return Center(
            child: Container(
              width: cardWidth,
              height: cardHeight,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.backgroundColor, width: 2),
                borderRadius: BorderRadius.circular(8),
                color: AppColors.white,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    children: [
                      ClipPath(
                        clipper: TopClipper(),
                        child: Container(
                          height: cardHeight * 0.26,
                          width: double.infinity,
                          color: AppColors.primaryColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.all_inclusive, color: Colors.white, size: 30),
                              SizedBox(height: 8),
                              Text(
                                "TuTr ",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                              Text(
                                "Find. Learn. Grow. Succeed.",
                                style: TextStyle(color: AppColors.white.withValues(alpha: 0.7), fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 85), // To give space for profile image

                      // Name and Role
                      Text(
                        teacherIdArgs.name.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 1,
                          color: AppColors.black,
                        ),
                      ),

                      Text(
                        "TEACHER",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Details
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IDDetailRow(title: "ID NO", value: teacherIdArgs.id),
                            IDDetailRow(title: "Experience", value: "${teacherIdArgs.experienceYears}+ Years"),
                            IDDetailRow(title: "Phone", value: teacherIdArgs.phone),
                            IDDetailRow(title: "Email", value: teacherIdArgs.email),
                            IDDetailRow(title: "Address", value: teacherIdArgs.address),
                            IDDetailRow(
                                title: "Joined On",
                                value: locatorDI<Helper>().formatTimeFronUnixTimeStamp(teacherIdArgs.joinedAt)),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // Barcode placeholder
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      //   child: Container(
                      //     height: 40,
                      //     // color: Colors.black12,
                      //     alignment: Alignment.center,
                      //     child: SfBarcodeGenerator(value: teacherIdArgs.id),
                      //   ),
                      // ),

                      // Bottom blue strip
                      Container(height: 10, width: double.infinity, color: AppColors.primaryColor),
                    ],
                  ),

                  // Profile Image (Floating)
                  Positioned(
                    top: cardHeight * 0.30 - profileRadius,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.secondaryColor,
                        ),
                        child: CircleAvatar(
                          radius: profileRadius,
                          backgroundColor: AppColors.white,
                          backgroundImage: teacherIdArgs.imageUrl.isEmpty
                              ? null
                              : const NetworkImage(
                                  'https://randomuser.me/api/portraits/men/75.jpg',
                                ),
                          child: teacherIdArgs.imageUrl.isEmpty
                              ? Center(
                                  child: Icon(
                                    Icons.person,
                                    size: 40.0.adptSP,
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class IDDetailRow extends StatelessWidget {
  final String title;
  final String value;
  const IDDetailRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(color: AppColors.secondaryColor, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          Expanded(flex: 1, child: Text(":", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          // const SizedBox(width: 5),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(color: AppColors.black, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class TopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(size.width / 2, size.height + 20, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

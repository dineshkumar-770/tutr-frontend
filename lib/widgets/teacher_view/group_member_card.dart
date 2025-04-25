// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/models/teacher_view_group_models/group_members_model.dart';

class GroupMemberCard extends StatelessWidget {
  final GroupMember member;
  final Function(TapDownDetails)?  onTap;

  const GroupMemberCard({
    super.key,
    required this.member,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              blurStyle: BlurStyle.outer,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(Icons.person, color: AppColors.white, size: 28),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member.studentFullName ?? "Unknown",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textColor2,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          member.studentEmail ?? "N/A",
                          style: TextStyle(fontSize: 13, color: AppColors.textColor2),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: InkWell( onTapDown:onTap , child: Icon(Icons.more_vert)),
                  )
                ],
              ),
              // Row(
              //   children: [
              //     infoRow(Icons.school, member.studentClass),
              //     Spacer(),
              //     infoRow(Icons.group, member.groupId),
              //   ],
              // ),
              // SizedBox(height: 8),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     contactInfo("Student", member.studentContact?.toString(), Colors.lightBlueAccent),
              //     contactInfo("Parent", member.studentParnetsContact?.toString(), Colors.redAccent),
              //   ],
              // ),

              // SizedBox(height: 8),

              // // Dates
              // Row(
              //   children: [
              //     infoRow(Icons.date_range, formatTimestamp(member.studentJoinedAt)),
              //     Spacer(),
              //     infoRow(Icons.account_circle, formatTimestamp(member.studentAccountCreationDate)),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoRow(IconData icon, String? value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textColor2),
        SizedBox(width: 4),
        Text(
          value ?? 'N/A',
          style: TextStyle(fontSize: 13, color: AppColors.textColor2),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget contactInfo(String title, String? number, Color highlightColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textColor2),
        ),
        GestureDetector(
          onTap: () {}, // Call functionality
          child: Row(
            children: [
              Icon(Icons.call, size: 18, color: highlightColor),
              SizedBox(width: 4),
              Text(
                number ?? 'N/A',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: highlightColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String formatTimestamp(int? timestamp) {
    if (timestamp == null) return "N/A";
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat("dd MMM yyyy").format(date);
  }
}

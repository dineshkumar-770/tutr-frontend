// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/constants/constant_strings.dart';
import 'package:tutr_frontend/core/common/gap.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/models/teacher_view_group_models/get_attendance_model.dart';
import 'package:tutr_frontend/utils/helpers.dart';

class AttendanceCalenderTile extends StatelessWidget {
  const AttendanceCalenderTile({
    super.key,
    required this.record,
    required this.isViewFromAllRecords,
    this.onTapMore,
    required this.isShowingTeacherView,
  });
  final AttendanceRecords record;
  final bool isViewFromAllRecords;
  final void Function(TapDownDetails)? onTapMore;
  final bool isShowingTeacherView;
  @override
  Widget build(BuildContext context) {
    final date = DateTime.tryParse(record.timestamp ?? '');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [
          BoxShadow(
            color: AppColors.grey, // Shadow color
            // Bottom me shadow ka position, yeh value badhane se bottom shadow zyada hoga
            blurRadius: 3, // Blur ka size (softer shadow effect)
            spreadRadius: 0.0, // Shadow ka spread, yeh value thoda increase kar sakte ho
            blurStyle: BlurStyle.outer,
          )
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [
                    Icon(
                      FontAwesomeIcons.calendar,
                      color: AppColors.textColor1,
                      size: 20,
                    ),
                    Text(
                      'Date: ${date != null ? locatorDI<Helper>().formatDateinDDMMMYYYY(date) : "Invalid"}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                if (locatorDI<Helper>().getUserType() == ConstantStrings.teacher) ...[
                  InkWell(onTapDown: onTapMore, child: Icon(Icons.more_vert))
                ]
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Remarks: ${record.remarks ?? "None"}',
              style: const TextStyle(color: Colors.grey),
            ),

            // Summary Row
            if (locatorDI<Helper>().getUserType() == ConstantStrings.teacher) ...[
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 12,
                  children: [
                    _buildSummaryCard('Present', record.presentStudents, AppColors.presentColor),
                    _buildSummaryCard('Absent', record.absentStudents, AppColors.absentColor),
                    _buildSummaryCard('Late', record.lateStudents, AppColors.lateColor),
                    _buildSummaryCard('Leave', record.leaveStudents, AppColors.leaveColor),
                    _buildSummaryCard('Total', record.totalStudents, AppColors.primaryColor),
                  ],
                ),
              ),
            ],
            Gaps.verticalGap(value: 8),
            isShowingTeacherView
                ? Container(
                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8)),
                    child: Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        minTileHeight: 25,
                        title: Text(
                          'Attendance Records',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textColor2),
                        ),
                        children: List.generate(
                          record.attendance?.length ?? 0,
                          (index) {
                            final student = record.attendance?[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.grey, // Shadow color
                                        // Bottom me shadow ka position, yeh value badhane se bottom shadow zyada hoga
                                        blurRadius: 3, // Blur ka size (softer shadow effect)
                                        spreadRadius: 0.0, // Shadow ka spread, yeh value thoda increase kar sakte ho
                                        blurStyle: BlurStyle.outer,
                                      )
                                    ],
                                    color: _statusColor(student?.status?.name ?? "-").withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12)),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: _statusColor(student?.status?.name ?? "-"),
                                    child: Text(
                                      student?.name?[0] ?? "",
                                      style: TextStyle(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    student?.name ?? "",
                                    style: TextStyle(color: AppColors.textColor2, fontSize: 12),
                                  ),
                                  subtitle: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      student?.stEmail ?? "",
                                      maxLines: 1,
                                      style: TextStyle(color: AppColors.textColor2, fontSize: 10),
                                    ),
                                  ),
                                  trailing: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: _statusColor(student?.status?.name ?? "-").withOpacity(0.1),
                                      border: Border.all(color: _statusColor(student?.status?.name ?? "-")),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      student?.status?.name ?? "",
                                      style: TextStyle(
                                          color: _statusColor(student?.status?.name ?? "-"),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _statusColor(record.attendance?[0].status?.name ?? "-"),
                      child: Text(
                        record.attendance?[0].name?[0] ?? "",
                        style: TextStyle(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      record.attendance?[0].name ?? "",
                      style: TextStyle(color: AppColors.textColor2, fontSize: 12),
                    ),
                    subtitle: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        record.attendance?[0].stEmail ?? "",
                        maxLines: 1,
                        style: TextStyle(color: AppColors.textColor2, fontSize: 10),
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: _statusColor(record.attendance?[0].status?.name ?? "-").withOpacity(0.1),
                        border: Border.all(color: _statusColor(record.attendance?[0].status?.name ?? "-")),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        record.attendance?[0].status?.name ?? "",
                        style: TextStyle(
                            color: _statusColor(record.attendance?[0].status?.name ?? "-"),
                            fontWeight: FontWeight.w600,
                            fontSize: 10),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String label, int? count, Color color) {
    return Chip(
      label: Text(
        '$label: ${count ?? 0}',
        style: TextStyle(fontWeight: FontWeight.w400, color: AppColors.textColor2, fontSize: 12),
      ),
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide(color: color),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'present':
        return AppColors.presentColor;
      case 'absent':
        return AppColors.absentColor;
      case 'late':
        return AppColors.lateColor;
      case 'leave':
        return AppColors.leaveColor;
      default:
        return AppColors.primaryColor;
    }
  }
}

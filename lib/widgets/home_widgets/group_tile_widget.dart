// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tutr_frontend/constants/app_colors.dart';

class GroupTileWidget extends StatelessWidget {
  const GroupTileWidget({
    super.key,
    required this.circleTitleText,
    required this.title,
    required this.groupDesc,
    required this.timeStamp,
    required this.className,
    required this.totalMembers,
  });
  final String circleTitleText;
  final String title;
  final String groupDesc;
  final int timeStamp;
  final String className;
  final String totalMembers;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(blurRadius: 1, blurStyle: BlurStyle.outer, spreadRadius: 1, color: AppColors.softGrayText)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListTile(
              isThreeLine: false,
              leading: CircleAvatar(
                radius: 25,
                child: Center(
                  child: Text(circleTitleText),
                ),
              ),
              title: Text(
                title,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.start,
                style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                groupDesc,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: AppColors.textColor2.withValues(alpha: 0.75), fontWeight: FontWeight.w300, fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "• $totalMembers members",
                        style: TextStyle(color: AppColors.primaryColor, fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      Text(
                          "• Created At ${DateFormat("dd MMM, yyyy").format(DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000))}",
                          style: TextStyle(color: AppColors.primaryColor, fontSize: 12, fontWeight: FontWeight.w500))
                    ],
                  ),
                  Container(
                    height: 30,
                    width: 120,
                    decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(180)),
                    child: Center(
                      child: Text(
                        "Class: $className",
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

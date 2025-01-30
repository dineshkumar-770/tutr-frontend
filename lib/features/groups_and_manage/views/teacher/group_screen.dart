// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tutr/common/custom_appbar.dart';
import 'package:tutr/resources/app_colors.dart';

class GroupScreenTeacher extends StatelessWidget {
  const GroupScreenTeacher({
    super.key,
    required this.groupTitle,
  });
  final String groupTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(),
        title: "",
        useWidgetOnTitle: true,
        titleWidget: Text(
          groupTitle,
          style: TextStyle(fontSize: 14, color: AppColors.textColor1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3.5,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  border: Border.all(width: 1, color: AppColors.textColor1),
                  borderRadius: BorderRadius.circular(4)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        "Announcements",
                        style: GoogleFonts.oldenburg(color: AppColors.textColor1, fontSize: 16),
                      ),
                      Divider(
                        color: AppColors.textColor1,
                      )
                    ],
                  )
                ],
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}

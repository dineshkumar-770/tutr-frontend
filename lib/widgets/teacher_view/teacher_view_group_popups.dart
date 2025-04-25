import 'package:flutter/material.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/core/common/custom_textfield.dart';
import 'package:tutr_frontend/core/common/gap.dart';
import 'package:tutr_frontend/core/common/tutr_button.dart';

class TeacherViewGroupPopups {
  Future<bool?> showNameReportPop({
    required BuildContext context,
    required TextEditingController titleController,
    required TextEditingController descController,
    required String titleString,
  }) async {
    return await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AnimatedPadding(
          duration: Duration(milliseconds: 300), // 👈 Smooth animation for auto-drag
          curve: Curves.easeOut,
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), // 👈 Auto-adjust for keyboard

          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.6,
            maxChildSize: 0.9,
            minChildSize: 0.4,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController, // 👈 Smooth scroll handling
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16, // 👈 Keyboard overlap fix
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        titleString,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor1,
                        ),
                      ),
                      Gaps.verticalGap(value: 20),
                      CustomTextField(
                        label: "Notice Title",
                        hint: "Enter title for the notice",
                        controller: titleController,
                      ),
                      Gaps.verticalGap(value: 15),
                      CustomTextField(
                        label: "Notice Description",
                        hint: "Enter description for your notice board",
                        maxLines: 3,
                        maxLength: 10000,
                        controller: descController,
                      ),
                      Gaps.verticalGap(value: 15),
                      TutrPrimaryButton(
                        onPressed: () {
                          if (titleController.text.isNotEmpty && descController.text.isNotEmpty) {
                            Navigator.pop(context, true);
                          } else {
                            Navigator.pop(context, false);
                          }
                        },
                        label: titleString,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<String?> showPopUpMenu(
      {required BuildContext context, required Offset position, required double tileWidth}) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    return await showMenu<String>(
      context: context,
      color: AppColors.backgroundColor,
      position: RelativeRect.fromLTRB(
        position.dx + tileWidth,
        position.dy,
        overlay.size.width - (position.dx + tileWidth),
        overlay.size.height - position.dy,
      ),
      items: [
        PopupMenuItem(
          value: "1",
          child: Text(
            "Call Student",
            style: TextStyle(color: AppColors.textColor1),
          ),
        ),
        PopupMenuItem(
          value: "2",
          child: Text("Call Parent", style: TextStyle(color: AppColors.textColor1)),
        ),
        PopupMenuItem(
          value: "3",
          child: Text("Sent Mail", style: TextStyle(color: AppColors.textColor1)),
        ),
        PopupMenuItem(
          value: "4",
          child: Text("Remove Student", style: TextStyle(color: AppColors.textColor1)),
        ),
      ],
    );
  }

  Future<String?> showPopUpMenuNotes(
      {required BuildContext context, required Offset position, required double tileWidth}) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    return await showMenu<String>(
      context: context,
      color: AppColors.backgroundColor,
      position: RelativeRect.fromLTRB(
        position.dx + tileWidth,
        position.dy,
        overlay.size.width - (position.dx + tileWidth),
        overlay.size.height - position.dy,
      ),
      items: [
        PopupMenuItem(
          value: "1",
          child: Text(
            "Delete Notes",
            style: TextStyle(color: AppColors.textColor1),
          ),
        ),
      ],
    );
  }
}

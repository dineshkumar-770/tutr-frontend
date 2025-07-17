import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/core/common/gap.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/models/doubts/doubts_posts_model.dart';
import 'package:tutr_frontend/utils/helpers.dart';

class DoubtPostCard extends StatelessWidget {
  final DoubetPost doubt;

  const DoubtPostCard({super.key, required this.doubt});

  @override
  Widget build(BuildContext context) {
    final helpers = locatorDI<Helper>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(blurRadius: 3, blurStyle: BlurStyle.outer, color: AppColors.black26, spreadRadius: 3)]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 4),
              leading: CircleAvatar(
                radius: 30,
                child: Text(
                  doubt.fullName?[0].toUpperCase() ?? "",
                  style: TextStyle(fontSize: 16, color: AppColors.textColor1),
                ),
              ),
              title: Text(
                doubt.fullName ?? "Unknown",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.textColor1),
              ),
              subtitle: Text(
                "Posted on: ${helpers.formatTimeFronUnixTimeStamp(doubt.createdAt ?? 0)}",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: AppColors.textColor1),
              ),
              trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: AppColors.textColor1,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Text(
                doubt.doubtText ?? "",
                style: TextStyle(color: AppColors.textColor1),
              ),
            ),
            if (doubt.attachedFiles != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      doubt.attachedFiles!.length,
                      (index) {
                        if (helpers.isImage(doubt.attachedFiles?[index].noteUrl ?? "")) {
                          return GestureDetector(
                            onTap: () {
                              locatorDI<Helper>().showImageFullScreen(context, doubt.attachedFiles?[index].noteUrl ?? "");
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: doubt.attachedFiles?[index].noteUrl ?? "",
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: AppColors.grey200,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child:  Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: AppColors.grey200,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child:  Icon(
                                      Icons.error_outline,
                                      color: AppColors.red,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else if (helpers.isPdf(doubt.attachedFiles?[index].noteUrl ?? "")) {
                          return GestureDetector(
                            onTap: () {
                              locatorDI<Helper>().showPDFFullScreen(context, doubt.attachedFiles?[index].noteUrl ?? "");
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: AppColors.grey200,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                      child: Icon(
                                    FontAwesomeIcons.filePdf,
                                    color: AppColors.red,
                                  )),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 5,
                    children: [
                      Container(
                        decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(200)),
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 5,
                            children: [
                              Icon(
                                Icons.chat_outlined,
                                size: 18,
                                color: AppColors.textColor1,
                              ),
                              Text(
                                "Reply",
                                style: TextStyle(color: AppColors.textColor1, fontSize: 12, fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(200)),
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 5,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                size: 18,
                                color: AppColors.textColor1,
                              ),
                              Text(
                                doubt.status?.toLowerCase() == "solved" ? "Solved" : "Mark as Solved",
                                style: TextStyle(color: AppColors.textColor1, fontSize: 12, fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(200)),
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 5,
                            children: [
                              Icon(
                                Icons.remove_red_eye_outlined,
                                size: 18,
                                color: AppColors.textColor1,
                              ),
                              Text(
                                "View Post",
                                style: TextStyle(color: AppColors.textColor1, fontSize: 12, fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gaps.verticalGap(value: 5)
            ]
          ],
        ),
      ),
    );
  }
}

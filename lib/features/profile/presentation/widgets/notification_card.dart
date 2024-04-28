import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/request/data/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notificationModel;
  const NotificationCard({required this.notificationModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: secondaryGrey,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.25),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: TxtStyle(
                    "${notificationModel.createdAt.hour}:${notificationModel.createdAt.minute}",
                    12,
                    fontWeight: FontWeight.bold,
                    color: darkGrey)),
            Row(
              children: [
                CircleAvatar(
                    minRadius: 20,
                    maxRadius: 20,
                    backgroundImage: NetworkImage(notificationModel.photo)),
                SizedBox(width: 10.w),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  TxtStyle(
                      "${notificationModel.fromName} -${notificationModel.notificationTitle}",
                      14,
                      fontWeight: FontWeight.bold),
                  TxtStyle(
                    "${notificationModel.notificationBody}",
                    12,
                    color: secondary,
                    fontWeight: FontWeight.normal,
                  ),
                ]),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

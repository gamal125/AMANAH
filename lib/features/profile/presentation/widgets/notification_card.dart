import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Container(
        padding: const EdgeInsets.all(16),
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
        child: Row(
          children: [
            const CircleAvatar(
                minRadius: 20, maxRadius: 20, backgroundColor: primary),
            SizedBox(width: 10.w),
            const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TxtStyle("Rashed", 20, fontWeight: FontWeight.bold),
              TxtStyle("rashed on hte way", 12, fontWeight: FontWeight.bold),
            ]),
            const Spacer(),
            const TxtStyle("2h", 12, fontWeight: FontWeight.bold, color: darkGrey),
          ],
        ),
      ),
    );
  }
}

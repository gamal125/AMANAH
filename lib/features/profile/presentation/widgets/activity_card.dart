import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 26, left: 12, right: 42),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const TxtStyle("Friday 2-2-2222", 18, color: darkGrey),
        const Divider(),
        const Row(
          children: [
            CircleAvatar(
                minRadius: 20, maxRadius: 20, backgroundColor: primary),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TxtStyle("  Rashed", 14, fontWeight: FontWeight.bold),
              ],
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 45.w),
            const TxtStyle("  jordan", 14, fontWeight: FontWeight.bold),
            const Icon(Icons.arrow_forward, color: primary),
            const TxtStyle("tripoli", 14, fontWeight: FontWeight.bold),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 45.w),
            const Icon(Icons.circle, color: primary, size: 12),
            const TxtStyle(" Food", 13, fontWeight: FontWeight.bold),
            const Spacer(),
            const Align(
              alignment: Alignment.bottomRight,
              child:  TxtStyle("219\$", 14,
                  fontWeight: FontWeight.bold, color: secondary),
            ),
          ],
        ),
      ]),
    );
  }
}

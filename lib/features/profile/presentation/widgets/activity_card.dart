import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../request/data/models/request_model.dart';

class ActivityCard extends StatelessWidget {
  final RequestModel requestModel;
  const ActivityCard({required this.requestModel, super.key});

  @override
  Widget build(BuildContext context) {
    final String dayFormat = DateFormat('EEEE').format(requestModel.date);
    final String date =
        "$dayFormat  ${requestModel.date.day}/${requestModel.date.month}/${requestModel.date.year}";
  
    return Padding(
      padding: const EdgeInsets.only(bottom: 26, left: 12, right: 42),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TxtStyle(date, 14, color: darkGrey),
            TxtStyle("Status: ${requestModel.status}", 14, color: primary),
          ],
        ),
        const Divider(),
        Row(
          children: [
            CircleAvatar(
                minRadius: 20,
                maxRadius: 20,
                backgroundImage: NetworkImage(requestModel.travellerPhoto)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TxtStyle("  ${requestModel.travellerName}", 14,
                    fontWeight: FontWeight.bold),
              ],
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 45.w),
            TxtStyle("  ${requestModel.from}", 14, fontWeight: FontWeight.bold),
            const Icon(Icons.arrow_forward, color: primary),
            TxtStyle(requestModel.to, 14, fontWeight: FontWeight.bold),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 45.w),
            const Icon(Icons.circle, color: primary, size: 12),
            TxtStyle(" ${requestModel.recommendedItemsToShip}", 13,
                fontWeight: FontWeight.bold),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: TxtStyle("${requestModel.itemPrice}\$", 14,
                  fontWeight: FontWeight.bold, color: secondary),
            ),
          ],
        ),
      ]),
    );
  }
}

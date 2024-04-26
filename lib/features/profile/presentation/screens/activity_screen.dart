import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/profile/presentation/widgets/activity_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios, color: secondary)),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const TxtStyle("Activities", 36, fontWeight: FontWeight.bold),
            SizedBox(height: 70.h),
            const ActivityCard(),
            const ActivityCard(),
          ],
        )));
  }
}

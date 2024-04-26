import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/profile/presentation/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios, color: secondary)),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(36),
          child: Column(
            children: [
              const TxtStyle("Notifications", 36, fontWeight: FontWeight.bold),
              SizedBox(height: 50.h),
              const Row(
                children: [
                  Icon(Icons.circle, color: primary, size: 12),
                  TxtStyle(" You have 3 notifications today", 14,
                      longText: true, fontWeight: FontWeight.bold),
                ],
              ),
              const NotificationCard(),
              const NotificationCard()
            ],
          ),
        )));
  }
}

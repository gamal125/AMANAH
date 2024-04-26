import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/custom_button.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel user;
  const ProfileScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: secondary)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(33.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                minRadius: 40,
                maxRadius: 40,
                backgroundImage: NetworkImage(user.personalImage)),
            TxtStyle("${user.firstName} ${user.lastName}", 20,
                fontWeight: FontWeight.bold),

            //stars
            SizedBox(height: 20.h),
            const Align(
              alignment: Alignment.topLeft,
              child: TxtStyle("Personal Information", 22,
                  fontWeight: FontWeight.bold),
            ),
            // Icon(Icons.edit, color: primary),
            ListTile(
              leading: const Icon(Icons.person, color: primary),
              title: TxtStyle(user.firstName, 20,
                  color: secondary, fontWeight: FontWeight.bold),
            ),

            ListTile(
              leading: const Icon(Icons.phone, color: primary),
              title: TxtStyle(user.phoneNumber, 18,
                  color: secondary, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: const Icon(Icons.email, color: primary),
              title: TxtStyle(user.email, 18,
                  color: secondary, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: primary),
              title: TxtStyle(user.country, 18,
                  color: secondary, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month, color: primary),
              title: TxtStyle(user.dateOfBirth, 18,
                  color: secondary, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            CustomButton(text: "Done", onPressed: () {})
          ],
        ),
      ),
    );
  }
}

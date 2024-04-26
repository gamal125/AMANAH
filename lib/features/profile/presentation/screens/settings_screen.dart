import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/custom_button.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios, color: secondary)),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const TxtStyle("Settings", 36, fontWeight: FontWeight.bold),
            SizedBox(height: 50.h),
            const ListTile(
              leading: Icon(Icons.edit, color: primary),
              title: TxtStyle("Edit Profile", 20,
                  color: secondary, fontWeight: FontWeight.bold),
            ),
            const ListTile(
              leading: Icon(Icons.change_circle_outlined, color: primary),
              title: TxtStyle("Change Password", 20,
                  color: secondary, fontWeight: FontWeight.bold),
            ),
            const ListTile(
              leading: Icon(Icons.delete, color: primary),
              title: TxtStyle("Delete Account", 20,
                  color: secondary, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            CustomButton(text: "Done", onPressed: () {})
          ]),
        ));
  }
}

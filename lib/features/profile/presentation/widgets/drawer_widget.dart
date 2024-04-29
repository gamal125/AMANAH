import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/functions/functions.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:amanah/features/profile/presentation/screens/activity_screen.dart';
import 'package:amanah/features/profile/presentation/screens/notification_screen.dart';
import 'package:amanah/features/profile/presentation/screens/profile_screen.dart';
import 'package:amanah/features/profile/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerWidget extends StatelessWidget {
  final UserModel user;
  const DrawerWidget({required this.user, super.key});
  // BlocProvider.value(
  //     value: studentCubit,

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 48, left: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(children: [
                CircleAvatar(
                    minRadius: 20,
                    maxRadius: 20,
                    backgroundImage: NetworkImage(user.profileImage!)),
                TxtStyle("  ${user.firstName}", 24, fontWeight: FontWeight.bold)
              ]),
              SizedBox(
                height: 20.h,
              ),
              ListTile(
                leading: const Icon(Icons.person, color: secondary),
                title: const TxtStyle("Profile", 16,
                    color: secondary, fontWeight: FontWeight.bold),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileScreen(user: user))),
              ),
              ListTile(
                leading:
                    const Icon(Icons.restart_alt_rounded, color: secondary),
                title: const TxtStyle("Your Activity", 16,
                    color: secondary, fontWeight: FontWeight.bold),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ActivityScreen(user: user))),
              ),
              ListTile(
                leading: const Icon(Icons.notifications, color: secondary),
                title: const TxtStyle("Notifications", 16,
                    color: secondary, fontWeight: FontWeight.bold),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen())),
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: secondary),
                title: const TxtStyle("Settings", 16,
                    color: secondary, fontWeight: FontWeight.bold),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen())),
              ),
              ListTile(
                  leading: const Icon(Icons.logout, color: secondary),
                  title: const TxtStyle("Log out", 16,
                      color: secondary, fontWeight: FontWeight.bold),
                  onTap: () => signOut(context)),
            ],
          ),
        ),
      ),
    );
  }
}

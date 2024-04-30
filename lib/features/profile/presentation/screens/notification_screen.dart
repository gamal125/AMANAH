import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/loading_widget.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/profile/application/notification_cubit/notification_cubit.dart';
import 'package:amanah/features/profile/application/notification_cubit/notification_states.dart';
import 'package:amanah/features/profile/presentation/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit()..getNotifications(),
      child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios, color: secondary)),
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(36),
            child: BlocBuilder<NotificationCubit, NotificationStates>(
              builder: (context, state) {
                if (state is NotificationLoadingState) {
                  return Column(
                    children: [
                      const TxtStyle("Notifications", 36,
                          fontWeight: FontWeight.bold),
                      SizedBox(height: 50.h),
                      const Row(
                        children: [
                          Icon(Icons.circle, color: primary, size: 12),
                          TxtStyle(" You don't have notifications today", 14,
                              longText: true, fontWeight: FontWeight.bold),
                        ],
                      ),
                      const Center(child: LoadingWidget())
                    ],
                  );
                } else if (state is NotificationLoadedState) {
                  return Column(
                    children: [
                      const TxtStyle("Notifications", 36,
                          fontWeight: FontWeight.bold),
                      SizedBox(height: 50.h),
                      Row(
                        children: [
                          const Icon(Icons.circle, color: primary, size: 12),
                          TxtStyle(
                              " You have ${state.notifications.length} notifications today",
                              14,
                              longText: true,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      ...state.notifications
                          .map((notification) => NotificationCard(
                                notificationModel: notification,
                              ))
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      const TxtStyle("Notifications", 36,
                          fontWeight: FontWeight.bold),
                      SizedBox(height: 50.h),
                      const Row(
                        children: [
                          Icon(Icons.circle, color: primary, size: 12),
                          TxtStyle(" You don't have notifications today", 14,
                              longText: true, fontWeight: FontWeight.bold),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
          ))),
    );
  }
}

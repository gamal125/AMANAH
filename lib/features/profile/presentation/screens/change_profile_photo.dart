// ignore_for_file: avoid_print

import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/custom_button.dart';
import 'package:amanah/core/utils/widgets/dialog.dart';
import 'package:amanah/core/utils/widgets/loading_widget.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:amanah/features/home/presentation/screens/home_screen.dart';
import 'package:amanah/features/profile/application/profile_cubit/profile_cubit.dart';
import 'package:amanah/features/profile/application/profile_cubit/profile_states.dart';
import 'package:amanah/features/profile/presentation/widgets/photo_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeProfilePhotoScreen extends StatelessWidget {
  final ProfileCubit profileCubit;
  final UserModel user;
  const ChangeProfilePhotoScreen(
      {required this.profileCubit, required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: secondary)),
      ),
      body: BlocProvider.value(
        value: BlocProvider.of<ProfileCubit>(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TxtStyle("Update Profile", 36, fontWeight: FontWeight.bold),
            SizedBox(height: 40.h),
            const TxtStyle("Select a new profile photo", 16,
                fontWeight: FontWeight.bold),
            Padding(
              padding: const EdgeInsets.only(top: 34, bottom: 100),
              child: BlocConsumer<ProfileCubit, ProfileStates>(
                listener: (context, state) {
                  if (state is ProfileUploadImageSuccessState) {
                    ShowDialog.show(
                        context, "Success", "Profile Photo Uploaded");
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! ProfilePickingImageLoadingState,
                          fallbackBuilder: (context) => const LoadingWidget(),
                          widgetBuilder: (context) {
                            return Center(
                                child: state
                                        is ProfileUploadingImageLoadingState
                                    ? const LoadingWidget()
                                    : Conditional.single(
                                        context: context,
                                        conditionBuilder: (context) => state
                                            is ProfileUploadImageSuccessState,
                                        fallbackBuilder: (context) =>
                                            GestureDetector(
                                                onTap: () async {
                                                  await profileCubit
                                                      .changePhoto(
                                                          context, user);
                                                },
                                                child: PhotoContainer(
                                                    url: user.profileImage)),
                                        widgetBuilder: (context) =>
                                            GestureDetector(
                                                onTap: () async {
                                                  await profileCubit
                                                      .changePhoto(
                                                          context, user);
                                                  print(profileCubit
                                                      .profileImage);
                                                },
                                                child: PhotoContainer(
                                                    url: profileCubit
                                                        .profileImage!)),
                                      ));
                          }),
                      Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! ProfileLoadingState,
                          fallbackBuilder: (BuildContext context) =>
                              const LoadingWidget(),
                          widgetBuilder: (context) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: CustomButton(
                                  text: "Save",
                                  onPressed: () {
                                    profileCubit.updateProfile(user).then(
                                        (value) => Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(user: value)),
                                            (Route<dynamic> route) => false));
                                  }),
                            );
                          })
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

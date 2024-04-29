import 'package:amanah/core/utils/widgets/custom_text_field.dart';
import 'package:amanah/core/utils/widgets/dialog.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/home/presentation/screens/home_screen.dart';
import 'package:amanah/features/profile/application/profile_cubit/profile_cubit.dart';
import 'package:amanah/features/profile/application/profile_cubit/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/widgets/custom_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ProfileCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 56),
          child: SingleChildScrollView(
            child: BlocConsumer<ProfileCubit, ProfileStates>(
              listener: (context, state) {
                if (state is ProfileChangePasswordSuccessState) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(user: state.user)),
                      (Route<dynamic> route) => false);
                }
                if (state is ProfileErrorState) {
                  ShowDialog.show(context, "Sorry", "Something went wrong");
                }
              },
              builder: (context, state) {
                ProfileCubit profileCubit = ProfileCubit.get(context);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 170.h),
                    const TxtStyle("Change Password", 36,
                        fontWeight: FontWeight.bold),
                    Padding(
                      padding: const EdgeInsets.only(top: 90, bottom: 6),
                      child: CustomTextField(
                          placeholder: "Password",
                          controller: profileCubit.passController,
                          isPassword: profileCubit.isPassword,
                          suffixIcon: profileCubit.suffixIcon,
                          suffixOnTap: () => profileCubit.changePassVisibilty(),
                          isPassField: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Don't let the field empty";
                            } else {
                              return null;
                            }
                          }),
                    ),
                    CustomTextField(
                        placeholder: "Confirm Password",
                        controller: profileCubit.confirmPassController,
                        isPassword: profileCubit.isPassword,
                        suffixIcon: profileCubit.suffixIcon,
                        suffixOnTap: () => profileCubit.changePassVisibilty(),
                        isPassField: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Confirm Your Password";
                          } else if (value !=
                              profileCubit.passController.text) {
                            return "Passwords doesn't match!";
                          } else {
                            return null;
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 200),
                      child: CustomButton(
                          text: "Save",
                          onPressed: () {
                            profileCubit.changePassword(context);
                          }),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

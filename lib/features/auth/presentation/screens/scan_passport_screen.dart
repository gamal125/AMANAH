// ignore_for_file: avoid_print

import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/custom_button.dart';
import 'package:amanah/core/utils/widgets/dialog.dart';
import 'package:amanah/core/utils/widgets/loading_widget.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/auth/application/signup_cubit/signup_states.dart';
import 'package:amanah/features/auth/presentation/screens/personal_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/signup_cubit/signup_cubit.dart';

class ScanPassportScreen extends StatelessWidget {
  final SignupCubit signupCubit;

  const ScanPassportScreen({required this.signupCubit, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: secondary)),
      ),
      body: BlocProvider.value(
        value: BlocProvider.of<SignupCubit>(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TxtStyle("Sign Up", 36, fontWeight: FontWeight.bold),
            SizedBox(height: 40.h),
            const TxtStyle("Scan your ID or your Passport", 16,
                fontWeight: FontWeight.bold),
            Padding(
              padding: const EdgeInsets.only(top: 34, bottom: 100),
              child: BlocConsumer<SignupCubit, SignupStates>(
                listener: (context, state) {
                  // if (state is PickingImageLoadingState) {
                  //   ShowDialog.show(context, "Please Wait",
                  //       "We're doing some progress in the back :)");
                  // }
                  if (state is UploadImagesSuccessState) {
                    ShowDialog.show(
                        context, "Success", "Complete  Registration!");
                  }

                  if (state is UploadImagesErrorState) {
                    ShowDialog.show(context, "Sorry", "Somthing went wrong!");
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! PickingImageLoadingState,
                          fallbackBuilder: (context) => const LoadingWidget(),
                          widgetBuilder: (context) {
                            return Center(
                                child: state is UploadImagesLoadingState
                                    ? const LoadingWidget()
                                    : Conditional.single(
                                        context: context,
                                        conditionBuilder: (context) =>
                                            state is UploadImagesSuccessState,
                                        fallbackBuilder: (context) =>
                                            GestureDetector(
                                                onTap: () async {
                                                  await signupCubit.uploadImage(
                                                      context, true);
                                                  // print(signupCubit.passportImageFile);
                                                },
                                                child: Image.asset(
                                                    "assets/images/passport_camera.png")),
                                        widgetBuilder: (context) =>
                                            GestureDetector(
                                          onTap: () async {
                                            await signupCubit.uploadImage(
                                                context, true);
                                            print(signupCubit.idImage);
                                          },
                                          child: Container(
                                            height: 250,
                                            width: 350,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      signupCubit.idImage),
                                                  fit: BoxFit.fill,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15)),
                                                border:
                                                    Border.all(color: primary)),
                                          ),
                                        ),
                                      ));
                          }),
                      Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! SignupLoadingState,
                          fallbackBuilder: (BuildContext context) =>
                              const LoadingWidget(),
                          widgetBuilder: (context) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: CustomButton(
                                  text: "Continue",
                                  onPressed: () {
                                    if (signupCubit.idImage == "") {
                                      ShowDialog.show(
                                          context, "Upload ID Photo", " ");
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider.value(
                                                      value: signupCubit,
                                                      child: PersonalImageScreen(
                                                          signupCubit:
                                                              signupCubit))));
                                    }
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

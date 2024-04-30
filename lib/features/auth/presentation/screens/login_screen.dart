import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/custom_button.dart';
import 'package:amanah/core/utils/widgets/custom_text_field.dart';
import 'package:amanah/core/utils/widgets/dialog.dart';
import 'package:amanah/core/utils/widgets/loading_widget.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/auth/application/login_cubit/login_cubit.dart';
import 'package:amanah/features/auth/application/login_cubit/login_states.dart';
import 'package:amanah/features/auth/presentation/screens/signup_screen.dart';
import 'package:amanah/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 56),
          child: SingleChildScrollView(
            child: BlocConsumer<LoginCubit, LoginStates>(
              listener: (context, state) {
                if (state is LoginSuccessState) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomeScreen(user: state.userModel)),
                      (Route<dynamic> route) => false);
                }
                if (state is LoginErrorState) {
                  ShowDialog.show(
                      context, "Sorry", "Check your login data again");
                }
              },
              builder: (context, state) {
                LoginCubit loginCubit = LoginCubit.get(context);
                return Form(
                  key: loginCubit.loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 170.h),
                      const TxtStyle("Log In", 36, fontWeight: FontWeight.bold),
                      Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: CustomTextField(
                            placeholder: "Email",
                            controller: loginCubit.emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Don't let the field empty";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      CustomTextField(
                          placeholder: "Password",
                          controller: loginCubit.passController,
                          isPassword: loginCubit.isPassword,
                          suffixIcon: loginCubit.suffixIcon,
                          suffixOnTap: () => loginCubit.changePassVisibilty(),
                          isPassField: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Don't let the field empty";
                            } else {
                              return null;
                            }
                          }),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: TxtStyle(
                          "Forget your password?",
                          13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 200),
                        child: Conditional.single(
                          context: context,
                          conditionBuilder: (context) => state is! LoginLoadingState,
                          fallbackBuilder: (context) => const LoadingWidget(),
                          widgetBuilder: (context) {
                            return CustomButton(
                                text: "Log In",
                                onPressed: () {
                                  if (loginCubit.loginFormKey.currentState!
                                      .validate()) {
                                    loginCubit.login();
                                  }
                                });
                          }
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const TxtStyle("Don't have an account?", 16,
                                fontWeight: FontWeight.bold),
                            GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupScreen())),
                                child: const TxtStyle(" Sign Up", 16,
                                    color: primary,
                                    fontWeight: FontWeight.bold)),
                          ])
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

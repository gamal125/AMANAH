import 'package:amanah/core/utils/widgets/custom_button.dart';
import 'package:amanah/core/utils/widgets/dialog.dart';
import 'package:amanah/core/utils/widgets/loading_widget.dart';
import 'package:amanah/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:amanah/features/auth/application/auth_cubit/auth_states.dart';
import 'package:amanah/features/auth/presentation/screens/login_screen.dart';
import 'package:amanah/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthCubit(),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 80, left: 46, right: 46, bottom: 100),
              child: Image.asset("assets/images/logo.png"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: BlocConsumer<AuthCubit, AuthStates>(
                  listener: (context, authState) {
                if (authState is AuthSuccessState) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomeScreen(user: authState.userModel)),
                      (Route<dynamic> route) => false);
                } else if (authState is AuthFailState) {
                  {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (Route<dynamic> route) => false);
                  }
                } else if (authState is AuthErrorState) {
                  ShowDialog.show(context, "Error", authState.message);
                }
              }, builder: (context, authState) {
                AuthCubit authCubit = AuthCubit.get(context);
                if (authState is AuthLoadingState) {
                  return const LoadingWidget();
                } else {
                  return CustomButton(
                      text: "Get Started",
                      onPressed: () => authCubit.checkSign()
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const LoginScreen()))
                      );
                }
              }),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0),
            ),
          ],
        ),
      ),
    );
  }
}

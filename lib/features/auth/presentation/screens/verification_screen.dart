import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/custom_button.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/auth/presentation/screens/login_screen.dart';
import 'package:amanah/features/auth/presentation/widgets/pinput_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios, color: secondary)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TxtStyle("Verification", 36, fontWeight: FontWeight.bold),
            SizedBox(height: 40.h),
            TxtStyle("Verify your Email", 24,
                color: secondarySoft, fontWeight: FontWeight.bold),
            TxtStyle("Enter your OTP code here", 14,
                color: secondarySoft, fontWeight: FontWeight.bold),
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 40),
              child: Center(
                  child: PinputWidget(otpController: usernameController)),
            ),
            TxtStyle("Resend Code?", 14,
                color: secondarySoft,
                fontWeight: FontWeight.bold,
                textDecoration: TextDecoration.underline),
            SizedBox(height: 30.h),
            CustomButton(
                text: "Verify",
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen())))
          ],
        ));
  }
}

import 'package:amanah/core/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class PinputWidget extends StatelessWidget {
  final TextEditingController otpController;

  const PinputWidget({super.key, required this.otpController});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
        width: 56,
        height: 56,
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        decoration: BoxDecoration(
          border: Border.all(color: primary),
          borderRadius: BorderRadius.circular(15.r),
        ));
    return Pinput(
      autofocus: true,
      length: 4,
      controller: otpController,
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
      listenForMultipleSmsOnAndroid: true,
      defaultPinTheme: defaultPinTheme,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Don't let the fields empty";
        } else if (value.characters.length < 4) {
          return "please enter 4 digits!";
        } else {
          return null;
        }
      },
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      onCompleted: (pin) {
        debugPrint('onCompleted: $pin');
      },
      onChanged: (value) {
        debugPrint('onChanged: $value');
      },
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 9),
            width: 22,
            height: 1,
            color: primary,
          ),
        ],
      ),
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: primary),
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: primary),
        ),
      ),
      errorPinTheme: defaultPinTheme.copyBorderWith(
        border: Border.all(color: Colors.redAccent),
      ),
    );
  }
}

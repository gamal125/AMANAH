import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/custom_button.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:amanah/features/home/presentation/screens/home_screen.dart';
import 'package:amanah/features/request/data/models/request_model.dart';
import 'package:amanah/features/request/presentation/widgets/request_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InProgressScreen extends StatelessWidget {
  final RequestModel requestModel;
  final UserModel user;
  const InProgressScreen(
      {required this.requestModel, required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 30.h),
          const TxtStyle("In Progress", 36, fontWeight: FontWeight.bold),
          Padding(
              padding: EdgeInsets.only(top: 25, bottom: 20),
              child: RequestWidget(requestModel: requestModel)),
          const Align(
              alignment: Alignment.topLeft,
              child:
                  TxtStyle("Payment Summary", 24, fontWeight: FontWeight.bold)),
          Row(
            children: [
              SizedBox(width: 30.w),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                TxtStyle("\nExtra Wieght", 16, color: secondarySoft),
                TxtStyle("\nExtra Size", 16, color: secondarySoft),
                TxtStyle("\nDistance Fees", 16, color: secondarySoft),
                TxtStyle("\nMore Safety", 16, color: secondarySoft),
                TxtStyle("\nTotal:", 20,
                    fontWeight: FontWeight.bold, color: secondarySoft),
              ]),
              SizedBox(width: 100.w),
              Column(children: [
                TxtStyle("\n${requestModel.extraWeight}\$", 16, color: primary),
                TxtStyle("\n${requestModel.extraSize}\$", 16, color: primary),
                TxtStyle("\n${requestModel.distanceFees}\$", 16,
                    color: primary),
                TxtStyle("\n${requestModel.moreSafety}\$", 16, color: primary),
                TxtStyle("\n${requestModel.lastPrice}\$", 20,
                    fontWeight: FontWeight.bold, color: secondarySoft),
              ])
            ],
          ),
          SizedBox(height: 20.h),
          CustomButton(
              text: "Done",
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(user: user)),
                    (Route<dynamic> route) => false);
              }),
          SizedBox(height: 20.h),
        ]),
      ),
    ));
  }
}

import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/custom_button.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/request/presentation/widgets/request_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InProgressScreen extends StatelessWidget {
  const InProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios, color: secondary)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(children: [
            const TxtStyle("In Progress", 36, fontWeight: FontWeight.bold),
            const Padding(
                padding: EdgeInsets.only(top: 25, bottom: 20),
                child: RequestWidget()),
            const Align(
                alignment: Alignment.topLeft,
                child: TxtStyle("Payment Summary", 24,
                    fontWeight: FontWeight.bold)),
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
                  const TxtStyle("\n100\$", 16, color: primary),
                  const TxtStyle("\n100\$", 16, color: primary),
                  const TxtStyle("\n100\$", 16, color: primary),
                  const TxtStyle("\n100\$", 16, color: primary),
                  TxtStyle("\n100\$", 20,
                      fontWeight: FontWeight.bold, color: secondarySoft),
                ])
              ],
            ),
            const Spacer(),
            CustomButton(text: "Done", onPressed: () {}),
            SizedBox(height: 20.h),
          ]),
        ));
  }
}

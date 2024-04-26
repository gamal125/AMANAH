import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/custom_button.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/request/presentation/screens/in_progress_screen.dart';
import 'package:amanah/features/request/presentation/widgets/calc_widget.dart';
import 'package:amanah/features/request/presentation/widgets/request_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TravellerRequestScreen extends StatelessWidget {
  const TravellerRequestScreen({super.key});

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
            const TxtStyle("Request", 36, fontWeight: FontWeight.bold),
            const Padding(
                padding: EdgeInsets.only(top: 25, bottom: 20),
                child: RequestWidget()),
            const Align(
                alignment: Alignment.topLeft,
                child: TxtStyle("Extra Services", 24,
                    fontWeight: FontWeight.bold)),
            Row(
              children: [
                SizedBox(width: 30.w),
                Expanded(
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TxtStyle("Extra Wieght", 16, color: secondarySoft),
                          const CalcWidget(),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TxtStyle("Extra Size", 16, color: secondarySoft),
                          const CalcWidget(),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TxtStyle("Distance Fees", 16, color: secondarySoft),
                          const CalcWidget(),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TxtStyle("More Safety", 16, color: secondarySoft),
                          const CalcWidget(),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TxtStyle("\nTotal:", 20,
                            fontWeight: FontWeight.bold, color: secondarySoft),
                        TxtStyle("\n100\$", 20,
                            fontWeight: FontWeight.bold, color: secondarySoft),
                      ],
                    ),
                  ]),
                ),
                SizedBox(width: 30.w),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  text: "Confirm",
                  width: 180,
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InProgressScreen())),
                ),
                CustomButton(
                  text: "Delete",
                  width: 180,
                  isDelete: true,
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const TravellerRequestScreen())),
                ),
              ],
            ),
            SizedBox(height: 20.h)
          ]),
        ));
  }
}

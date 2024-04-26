import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/custom_button.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/request/presentation/screens/in_progress_screen.dart';
import 'package:amanah/features/request/presentation/screens/traveller_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios, color: secondary)),
        ),
        body: Column(children: [
          const TxtStyle("Confirm Request", 36, fontWeight: FontWeight.bold),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: primary)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(children: [
                      CircleAvatar(
                          minRadius: 20,
                          maxRadius: 20,
                          backgroundColor: primary),
                      TxtStyle("  rasehd", 24, fontWeight: FontWeight.bold)
                    ]),
                    const TxtStyle("\nExtra Services", 24,
                        fontWeight: FontWeight.bold),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TxtStyle("\nExtra Wieght", 16,
                                  fontWeight: FontWeight.bold,
                                  color: secondarySoft),
                              TxtStyle("Extra Size", 16,
                                  fontWeight: FontWeight.bold,
                                  color: secondarySoft),
                              TxtStyle("Distance Fees", 16,
                                  fontWeight: FontWeight.bold,
                                  color: secondarySoft),
                              TxtStyle("More Safety", 16,
                                  fontWeight: FontWeight.bold,
                                  color: secondarySoft),
                              const TxtStyle("\nTotal:", 20,
                                  fontWeight: FontWeight.bold),
                            ]),
                        SizedBox(width: 10.w),
                        const Column(children: [
                          TxtStyle("\n100\$", 16, color: primary),
                          TxtStyle("100\$", 16, color: primary),
                          TxtStyle("100\$", 16, color: primary),
                          TxtStyle("100\$", 16, color: primary),
                          TxtStyle("\n100\$", 20),
                        ])
                      ],
                    ),
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
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
          )
        ]));
  }
}

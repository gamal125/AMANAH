import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/custom_button.dart';
import 'package:amanah/core/utils/widgets/custom_text_field.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/request/presentation/screens/confirm_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: secondary)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: TxtStyle("Request", 36, fontWeight: FontWeight.bold)),
            const TxtStyle("\nItem description", 24,
                fontWeight: FontWeight.bold),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 22.0),
                child: CustomTextField(
                    placeholder: "Item description",
                    isDesc: true,
                    controller: controller,
                    validator: (d) {
                      return "";
                    }),
              ),
            ),
            const TxtStyle("Weight", 24, fontWeight: FontWeight.bold),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22.0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomTextField(
                    placeholder: "00",
                    controller: controller,
                    isDate: true,
                    isNumbers: true,
                    validator: (d) {
                      return "";
                    }),
                SizedBox(width: 20.w),
                CustomTextField(
                    placeholder: "KG",
                    isDate: true,
                    readOnly: true,
                    controller: controller,
                    validator: (d) {
                      return "";
                    }),
              ]),
            ),
            const TxtStyle("Size", 24, fontWeight: FontWeight.bold),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomTextField(
                        placeholder: "Height",
                        isDate: true,
                        isNumbers: true,
                        controller: controller,
                        validator: (d) {
                          return "";
                        }),
                    CustomTextField(
                        placeholder: "Weidth",
                        isDate: true,
                        isNumbers: true,
                        controller: controller,
                        validator: (d) {
                          return "";
                        }),
                    CustomTextField(
                        placeholder: "Depth",
                        isDate: true,
                        isNumbers: true,
                        controller: controller,
                        validator: (d) {
                          return "";
                        }),
                  ]),
            ),
            const TxtStyle("Item Price", 24, fontWeight: FontWeight.bold),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22.0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomTextField(
                    placeholder: "00",
                    isDate: true,
                    isNumbers: true,
                    controller: controller,
                    validator: (d) {
                      return "";
                    }),
                SizedBox(width: 20.w),
                CustomTextField(
                    placeholder: "\$",
                    isDate: true,
                    readOnly: true,
                    controller: controller,
                    validator: (d) {
                      return "";
                    }),
              ]),
            ),
            const Spacer(),
            Center(child: CustomButton(text: "Request", onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ConfirmScreen())),))
          ],
        ),
      ),
    );
  }
}

import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowDialog {
  static Future<dynamic> show(context, String title, String discription,
      {String buttonText = 'OK'}) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.r)),
            elevation: 0.0,
            backgroundColor: Colors.white,
            child: Container(
              width: 327.w,
              height: 218.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r)),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 28.h),
                    TxtStyle(title, 18, textAlignm: TextAlign.center),
                    SizedBox(height: 12.h),
                    Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        width: 258,
                        height: 56,
                        child: TxtStyle(discription, 12,
                            textAlignm: TextAlign.center)),
                    SizedBox(height: 24.h),
                    Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        width: 287,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, 'ok');
                          },
                          child: const TxtStyle("Okay", 14),
                        ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}

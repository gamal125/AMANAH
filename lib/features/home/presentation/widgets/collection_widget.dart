import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollectionWidget extends StatelessWidget {
  final String imagePath, title;
  const CollectionWidget(
      {required this.imagePath, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: 42.h,
            width: 42.w,
            // padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.35),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(0, 4)),
              ],
            ),
            child: Image.asset(imagePath)),
        TxtStyle(title, 12, color: Colors.white, fontWeight: FontWeight.bold)
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final Color backgroundColor;
//   final Color textColor;
//   final double width;

//   const CustomButton({
//     Key? key,
//     required this.text,
//     required this.onPressed,
//     this.backgroundColor = const Color(0xFFF93929), // Default to orange color
//     this.textColor = Colors.white, // Default to white color
//     this.width = double.infinity, // Default to max width
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width, // Use the width passed to the constructor
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: backgroundColor,
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.r),
//           ),
//         ),
//         onPressed: onPressed,
//         child: Text(
//           text,
//           style: TextStyle(fontSize: 24.sp, color: textColor),
//         ),
//       ),
//     );
//   }
// }

import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final int width;
  final bool isDelete;
  const CustomButton({
    required this.text,
    required this.onPressed,
    this.isDelete = false,
    this.width = 208,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 55.h,
        width: width.toDouble().w,
        decoration: BoxDecoration(
          border: Border.all(color: isDelete ? primary : Colors.transparent),
          borderRadius: BorderRadius.circular(15.r),
          color: isDelete ? Colors.white : primary,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.35),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Center(
          child: TxtStyle(
            text,
            24.sp,
            color: isDelete ? primary : Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

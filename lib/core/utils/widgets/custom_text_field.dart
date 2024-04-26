// import 'package:amanah/core/utils/colors/colors.dart';
// import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final String placeholder;
//   final double width;
//   final double height;
//   final bool isPassword;
//   final TextEditingController controller; // Added controller

//   const CustomTextField({
//     Key? key,
//     required this.placeholder,
//     required this.controller, // Make controller a required parameter
//     this.width = double.infinity,
//     this.height = 56.0, // Default height for text fields
//     this.isPassword = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width,
//       height: height,
//       child: TextFormField(
//         controller: controller, // Use the passed controller
//         obscureText: isPassword,
//         decoration: InputDecoration(
//           labelText: placeholder,
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: primary, width: 2.0),
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color:primary, width: 2.0),
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           suffixIcon: isPassword
//               ? Icon(Icons.visibility_off, color:primary)
//               : null,
//         ),
//       ),
//     );
//   }
// }

import 'package:amanah/core/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String placeholder;
  final TextEditingController? controller;
  final int width;
  final bool isNumbers,
      isPassword,
      isPassField,
      isDesc,
      isPrice,
      isSearch,
      isDate,
      readOnly;
  final VoidCallback? onTap;
  // final VoidCallback? onChanged;
  final void Function()? suffixOnTap;
  final void Function(String)? onChanged;

  final IconData suffixIcon;

  final FormFieldValidator<String> validator;

  const CustomTextField({
    required this.placeholder,
    required this.controller,
    required this.validator,
    this.readOnly = false,
    this.isDate = false,
    this.suffixIcon = Icons.visibility_outlined,
    this.suffixOnTap,
    this.isNumbers = false,
    this.isPassword = false,
    this.isPassField = false,
    this.isDesc = false,
    this.isSearch = false,
    this.isPrice = false,
    // this.isLocation = false,
    this.onTap,
    this.onChanged,
    this.width = 327,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 55.h,
        width: isSearch
            ? 281.w
            : isDate
                ? 90.w
                : 318.w,
        child: TextFormField(
          onTap: onTap,
          readOnly: readOnly,
          onChanged: onChanged,
          maxLines: isDesc == true ? 3 : 1,
          obscureText: isPassword,
          keyboardType: isNumbers == true || isPrice == true
              ? TextInputType.number
              : TextInputType.text,
          validator: validator,
          controller: controller,
          cursorColor: primary,
          style: const TextStyle(
              fontFamily: 'Inter',
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            suffixIcon: isPassField
                ? IconButton(
                    onPressed: suffixOnTap,
                    icon: Icon(
                      suffixIcon,
                      color: darkGrey,
                    ),
                  )
                : null,
            prefixIcon: isSearch
                ? IconButton(
                    onPressed: suffixOnTap,
                    icon: const Icon(
                      Icons.search,
                      color: darkGrey,
                    ),
                  )
                : null,
            fillColor: Colors.white,
            filled: true,
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(isSearch ? 25.r : 15.r),
                borderSide: const BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(isSearch ? 25.r : 15.r),
                borderSide: BorderSide(color: isSearch ? darkGrey : primary)),
            hintText: placeholder,
            hintStyle: TextStyle(
                fontFamily: 'Inter',
                color: secondarySoft,
                fontSize: 12,
                fontWeight: FontWeight.bold),
            errorStyle: const TextStyle(
                height: 0,
                fontFamily: 'Inter',
                color: Colors.red,
                fontSize: 9,
                fontWeight: FontWeight.bold),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(color: Colors.red)),
            errorBorder: OutlineInputBorder(
              gapPadding: 0,
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(15.r),
            ),
            enabledBorder: OutlineInputBorder(
              gapPadding: 0,
              borderSide: BorderSide(color: isSearch ? darkGrey : primary),
              borderRadius: BorderRadius.circular(isSearch ? 25.r : 15.r),
            ),
          ),
        ),
      ),
    );
  }
}

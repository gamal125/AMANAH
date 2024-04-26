import 'package:amanah/core/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String image;
  final TextEditingController controller;
  final VoidCallback? onTap;
  const HeaderWidget(
      {required this.controller, this.onTap, required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
            minRadius: 30, maxRadius: 30, backgroundImage: NetworkImage(image)),
      ),
      CustomTextField(
          isSearch: true,
          placeholder: " ",
          controller: controller,
          validator: (validator) {
            return "f";
          })
    ]);
  }
}

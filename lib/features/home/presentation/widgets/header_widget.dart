import 'package:amanah/core/utils/widgets/custom_text_field.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:amanah/features/home/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final UserModel userModel;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final bool isSearching;
  const HeaderWidget(
      {required this.controller,
      this.onTap,
      required this.userModel,
      this.onChanged,
      this.isSearching = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
            minRadius: 30,
            maxRadius: 30,
            backgroundImage: NetworkImage(userModel.profileImage!)),
      ),
      CustomTextField(
          onTap: isSearching
              ? null
              : () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SearchScreen(userModel: userModel))),
          readOnly: isSearching ? false : true,
          isSearch: true,
          onChanged: isSearching ? (onChanged!) : null,
          placeholder: " ",
          controller: controller,
          validator: (validator) {
            return null;
          })
    ]);
  }
}

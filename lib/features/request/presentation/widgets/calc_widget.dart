import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:flutter/material.dart';

class CalcWidget extends StatelessWidget {
  const CalcWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 14.0),
      child: Row(
        children: [
          CircleAvatar(
              radius: 12,
              backgroundColor: primary,
              child: Center(child: Icon(Icons.add, color: Colors.white))),
          TxtStyle(" 10 ", 20),
          CircleAvatar(
              radius: 12,
              backgroundColor: primary,
              child: Icon(Icons.remove, color: Colors.white)),
        ],
      ),
    );
  }
}
import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({this.title = "Most Popular", super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      TxtStyle(title, 32, fontWeight: FontWeight.bold),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Align(
            alignment: Alignment.center,
            child: TxtStyle("Newest  ", 14,
                fontWeight: FontWeight.bold, color: darkGrey),
          ),
          Align(
              alignment: Alignment.center,
              child: Image.asset("assets/icons/up_down_arrow.png"))
        ],
      )
    ]);
  }
}

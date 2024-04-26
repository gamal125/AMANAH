import 'package:amanah/core/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TxtStyle extends StatelessWidget {
  const TxtStyle(this._text, this._size,
      {super.key,
      this.textDecoration,
      this.fontWeight = FontWeight.normal,
      this.color = secondary,
      this.textAlignm,
      this.decorationColor,
      this.longText = false,
      this.isDescribtion = false});
  final String _text;
  final bool longText, isDescribtion;
  final Color color;
  final double _size;
  final FontWeight fontWeight;
  final TextDecoration? textDecoration;
  final TextAlign? textAlignm;
  final Color? decorationColor;

  @override
  Widget build(BuildContext context) {
    return Text(
        longText == false
            ? _text.length > 30
                ? '${_text.substring(0, 30)}...'
                : _text
            : _text,
        textAlign: textAlignm,
        maxLines: isDescribtion ? 5 : 2,
        style: TextStyle(
          decoration: textDecoration,
          decorationColor: decorationColor,
          color: color,
          fontSize: _size.sp,
          fontWeight: fontWeight,
        ));
  }
}

import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestWidget extends StatelessWidget {
  const RequestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: primary)),
                child: Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: Column(children: [
                    const Row(children: [
                      CircleAvatar(
                          minRadius: 20,
                          maxRadius: 20,
                          backgroundColor: primary),
                      TxtStyle("  rasehd", 24, fontWeight: FontWeight.bold)
                    ]),
                    SizedBox(height: 20.h),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TxtStyle("Item", 18, fontWeight: FontWeight.bold),
                          Row(
                            children: [
                              const Icon(Icons.circle,
                                  color: primary, size: 12),
                              TxtStyle(" Food", 16, color: secondarySoft),
                            ],
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TxtStyle("Weight", 18, fontWeight: FontWeight.bold),
                          TxtStyle("100\$", 16, color: secondarySoft),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TxtStyle("Size", 18, fontWeight: FontWeight.bold),
                          Column(
                            children: [
                              TxtStyle("H 100 cm", 16, color: secondarySoft),
                              TxtStyle("W 100 cm", 16, color: secondarySoft),
                              TxtStyle("D 100 cm", 16, color: secondarySoft),
                            ],
                          ),
                        ]),
                    TxtStyle("\nItem Price: 50\$", 18,
                        color: secondarySoft, fontWeight: FontWeight.bold),
                  ]),
                ),
              )
        ;
  }
}
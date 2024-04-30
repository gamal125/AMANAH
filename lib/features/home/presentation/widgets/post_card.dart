import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/home/data/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostCard extends StatelessWidget {
  final PostModel postModel;
  const PostCard({required this.postModel, super.key});

  @override
  Widget build(BuildContext context) {
    bool inHours = true;

    Duration difference = DateTime.now().difference(postModel.createdAt);
    if (difference.inHours == 24) {
      inHours = false;
    } else {
      inHours = true;
    }
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
            color: softGrey,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.35),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 4)),
            ],
            borderRadius: BorderRadius.circular(15.r)),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          minRadius: 20,
                          maxRadius: 20,
                          backgroundImage: NetworkImage(postModel.userPhoto)),
                      Center(
                          child: TxtStyle("  ${postModel.userName}", 14,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TxtStyle(
                        difference.inHours == 0
                            ? "${difference.inMinutes.toString()}m"
                            : inHours
                                ? "${difference.inHours.toString()}h"
                                : "${difference.inDays.toString()}d",
                        // "${postModel.createdAt.hour}:${postModel.createdAt.minute}\n${postModel.createdAt.day}/${postModel.createdAt.month}",
                        10,
                        fontWeight: FontWeight.bold,
                        color: darkGrey),
                  ),
                ],
              ),
              //way to go
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TxtStyle("From", 10,
                              fontWeight: FontWeight.bold, color: darkGrey),
                          TxtStyle(postModel.currentLocation, 13,
                              fontWeight: FontWeight.bold),
                        ]),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Icon(Icons.arrow_forward, color: primary),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TxtStyle("To", 10,
                            fontWeight: FontWeight.bold, color: darkGrey),
                        TxtStyle(postModel.destination, 13,
                            fontWeight: FontWeight.bold),
                      ],
                    )
                  ],
                ),
              ),
              //
              Row(
                children: [
                  const Icon(Icons.circle, color: primary, size: 12),
                  TxtStyle(" ${postModel.recommendedItemsToShip}", 13,
                      fontWeight: FontWeight.bold),
                ],
              ),
              TxtStyle("Base Price   ${postModel.basePrice}\$", 11,
                  fontWeight: FontWeight.bold),
            ]));
  }
}

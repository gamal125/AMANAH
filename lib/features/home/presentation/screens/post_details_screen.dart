import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/custom_button.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:amanah/features/home/data/models/post_model.dart';
import 'package:amanah/features/home/presentation/screens/home_screen.dart';
import 'package:amanah/features/request/presentation/screens/request_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostDetailsScreen extends StatelessWidget {
  final PostModel postModel;
  final bool isTraveller;
  final UserModel? userModel;
  const PostDetailsScreen(
      {required this.postModel,
      this.userModel,
      this.isTraveller = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: secondary)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                minRadius: 40,
                maxRadius: 40,
                backgroundImage: NetworkImage(postModel.userPhoto)),
            TxtStyle(postModel.userName, 33, fontWeight: FontWeight.bold),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const TxtStyle("From", 14,
                      fontWeight: FontWeight.bold, color: darkGrey),
                  TxtStyle(postModel.currentLocation, 24,
                      fontWeight: FontWeight.bold),
                ]),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(Icons.arrow_forward, color: primary),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TxtStyle("To", 14,
                        fontWeight: FontWeight.bold, color: darkGrey),
                    TxtStyle(postModel.destination, 24,
                        fontWeight: FontWeight.bold),
                  ],
                )
              ],
            ),
            SizedBox(height: 30.h),
            //informations
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TxtStyle("Travel Date", 20,
                          fontWeight: FontWeight.bold, color: secondarySoft),
                      TxtStyle(postModel.travelDate, 16, color: secondarySoft),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TxtStyle("Travel Time", 20,
                          fontWeight: FontWeight.bold, color: secondarySoft),
                      TxtStyle(postModel.travelTime, 16, color: secondarySoft),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TxtStyle("Arrival Date", 20,
                          fontWeight: FontWeight.bold, color: secondarySoft),
                      TxtStyle(postModel.arrivalDate, 16, color: secondarySoft),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TxtStyle("Arrival Time", 20,
                          fontWeight: FontWeight.bold, color: secondarySoft),
                      TxtStyle(postModel.arrivalTime, 16, color: secondarySoft),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TxtStyle("Weight", 20,
                          fontWeight: FontWeight.bold, color: secondarySoft),
                      TxtStyle(postModel.availableWeight.toString(), 16,
                          color: secondarySoft),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TxtStyle("Recommended Items", 20,
                    fontWeight: FontWeight.bold, color: secondarySoft),
                Row(
                  children: [
                    const Icon(Icons.circle, color: primary, size: 12),
                    TxtStyle(" ${postModel.recommendedItemsToShip}", 16,
                        fontWeight: FontWeight.bold, color: secondarySoft),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TxtStyle("\nBase Price     ${postModel.basePrice}\$", 20,
                  fontWeight: FontWeight.bold, color: secondarySoft),
            ),
            const Spacer(),
            CustomButton(
              text: userModel!.userId == postModel.userId ? "Done" : "Request",
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          userModel!.userId == postModel.userId
                              ? HomeScreen(user: userModel!)
                              :  RequestScreen(userModel: userModel!, postModel: postModel))),
            ),
          ],
        ),
      ),
    );
  }
}

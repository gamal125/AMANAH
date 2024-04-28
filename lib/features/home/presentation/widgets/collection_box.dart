import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:amanah/features/home/application/post_cubit/post_cubit.dart';
import 'package:amanah/features/home/presentation/screens/search_screen.dart';
import 'package:amanah/features/home/presentation/widgets/collection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollectionsBox extends StatelessWidget {
  final UserModel userModel;
  const CollectionsBox({required this.userModel, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<PostCubit>(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
            color: secondary, borderRadius: BorderRadius.circular(15.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TxtStyle(
              "Top Collections",
              20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                              value: PostCubit(),
                              child: SearchScreen(
                                  userModel: userModel,
                                  collectionName: "food")))),
                  child: const CollectionWidget(
                      imagePath: "assets/icons/food.png", title: "Food"),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                              value: PostCubit(),
                              child: SearchScreen(
                                  userModel: userModel,
                                  collectionName: "Electronics")))),
                  child: const CollectionWidget(
                      imagePath: "assets/icons/elec.png", title: "Electronics"),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                              value: PostCubit(),
                              child: SearchScreen(
                                  userModel: userModel,
                                  collectionName: "Toys")))),
                  child: const CollectionWidget(
                      imagePath: "assets/icons/toys.png", title: "Toys"),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                              value: PostCubit(),
                              child: SearchScreen(
                                  userModel: userModel,
                                  collectionName: "cosmetics")))),
                  child: const CollectionWidget(
                      imagePath: "assets/icons/coz.png", title: "Cosmetics"),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                              value: PostCubit(),
                              child: SearchScreen(
                                  userModel: userModel,
                                  collectionName: "clothes")))),
                  child: const CollectionWidget(
                      imagePath: "assets/icons/clothes.png", title: "Clothes"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/loading_widget.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/home/application/post_cubit/post_cubit.dart';
import 'package:amanah/features/home/application/post_cubit/post_states.dart';
import 'package:amanah/features/home/presentation/screens/add_post_screen.dart';
import 'package:amanah/features/home/presentation/screens/post_details_screen.dart';
import 'package:amanah/features/home/presentation/widgets/header_widget.dart';
import 'package:amanah/features/home/presentation/widgets/post_card.dart';
import 'package:amanah/features/profile/presentation/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../auth/data/models/user_model.dart';
import '../widgets/collection_widget.dart';

class HomeScreen extends StatelessWidget {
  final UserModel user;
  const HomeScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    TextEditingController controller = TextEditingController();
    return BlocProvider(
      create: (context) => PostCubit()..getPostsByType("Food"),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        drawer: DrawerWidget(user: user),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                      value: PostCubit(),
                      child: AddPostScreen(userModel: user)))),
          shape: const CircleBorder(),
          backgroundColor: primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(26),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 35, bottom: 40),
                    child: GestureDetector(
                        child: HeaderWidget(
                            userModel: user,
                            controller: controller,
                            onTap: () =>
                                scaffoldKey.currentState!.openDrawer()))),
                //collection box
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                  decoration: BoxDecoration(
                      color: secondary,
                      borderRadius: BorderRadius.circular(15.r)),
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
                      BlocBuilder<PostCubit, PostStates>(
                        builder: (context, state) {
                          PostCubit postCubit = PostCubit.get(context);
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () => postCubit.getPostsByType("Food"),
                                child: const CollectionWidget(
                                    imagePath: "assets/icons/food.png",
                                    title: "Food"),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    postCubit.getPostsByType("Electronics"),
                                child: const CollectionWidget(
                                    imagePath: "assets/icons/elec.png",
                                    title: "Electronics"),
                              ),
                              GestureDetector(
                                onTap: () => postCubit.getPostsByType("Toys"),
                                child: const CollectionWidget(
                                    imagePath: "assets/icons/toys.png",
                                    title: "Toys"),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    postCubit.getPostsByType("Cosmetics"),
                                child: const CollectionWidget(
                                    imagePath: "assets/icons/coz.png",
                                    title: "Cosmetics"),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    postCubit.getPostsByType("Clothes"),
                                child: const CollectionWidget(
                                    imagePath: "assets/icons/clothes.png",
                                    title: "Clothes"),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TxtStyle("Most Popular", 32,
                          fontWeight: FontWeight.bold),
                      BlocBuilder<PostCubit, PostStates>(
                        builder: (context, state) {
                          PostCubit postCubit = PostCubit.get(context);
                          return GestureDetector(
                            onTap: () => postCubit
                                .getPostsByType(postCubit.collectionName),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: TxtStyle(
                                      postCubit.newest
                                          ? "Newest  "
                                          : "Oldest  ",
                                      14,
                                      fontWeight: FontWeight.bold,
                                      color: darkGrey),
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                        "assets/icons/up_down_arrow.png"))
                              ],
                            ),
                          );
                        },
                      )
                    ]),
                Expanded(
                    child: BlocConsumer<PostCubit, PostStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is PostLoadingState) {
                      return const LoadingWidget();
                    } else if (state is GetPostsSuccessState) {
                      return GridView.builder(
                          itemCount: state.posts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          // physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostDetailsScreen(
                                          postModel: state.posts[index],
                                          userModel: user))),
                              child: PostCard(postModel: state.posts[index])));
                    } else {
                      return Conditional.single(
                          context: context,
                          conditionBuilder: (context) => state is NoPostsState,
                          widgetBuilder: (context) => const Center(
                                child: TxtStyle("No Posts Yet", 14),
                              ),
                          fallbackBuilder: (context) => const SizedBox());
                    }
                  },
                ))
              ]),
        ),
      ),
    );
  }
}

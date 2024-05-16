// ignore_for_file: avoid_print, file_names

import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/loading_widget.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:amanah/features/home/application/post_cubit/post_cubit.dart';
import 'package:amanah/features/home/application/post_cubit/post_states.dart';
import 'package:amanah/features/home/presentation/screens/post_details_screen.dart';
import 'package:amanah/features/home/presentation/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class MyPostsScreen extends StatelessWidget {
  final UserModel user;
  const MyPostsScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PostCubit()..getMyAllPostsByType(user.userId),
    child: Scaffold(
    appBar: AppBar(
      title:          const TxtStyle('My Posts',33,longText: true,fontWeight: FontWeight.bold,),
        centerTitle: true,
    elevation: 4,
    leading: InkWell(
    onTap: () => Navigator.pop(context),
    child: const Icon(Icons.arrow_back_ios, color: secondary)),
    ),
    body:    Container(
padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const SizedBox(height: 10,),
          Expanded(
          child: BlocConsumer<PostCubit, PostStates>(
          listener: (context, state) {},
          builder: (context, state) {
          if (state is MyPostLoadingState) {
          return const LoadingWidget();
          } else if (state is GetMyPostsSuccessState) {
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
          child: MyPostCard(postModel: state.posts[index], postId: state.idPosts[index],)));
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
          )),
        ],
      ),
    )
    ));
  }
}

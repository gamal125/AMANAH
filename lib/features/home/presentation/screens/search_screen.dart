import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/loading_widget.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:amanah/features/home/application/user_cubit/post_cubit.dart';
import 'package:amanah/features/home/application/user_cubit/post_states.dart';
import 'package:amanah/features/home/presentation/screens/add_post_screen.dart';
import 'package:amanah/features/home/presentation/screens/post_details_screen.dart';
import 'package:amanah/features/home/presentation/widgets/header_widget.dart';
import 'package:amanah/features/home/presentation/widgets/post_card.dart';
import 'package:amanah/features/home/presentation/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class SearchScreen extends StatelessWidget {
  final UserModel userModel;
  final String collectionName;
  const SearchScreen(
      {required this.userModel, required this.collectionName, super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return BlocProvider.value(
      value: BlocProvider.of<PostCubit>(context)
        ..getPostsByType(collectionName),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddPostScreen(userModel: userModel))),
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
                    child: HeaderWidget(controller: controller, image: "")),
                TitleWidget(title: collectionName),
                Expanded(child: BlocBuilder<PostCubit, PostStates>(
                  builder: (context, state) {
                    if (state is PostLoadingState) {
                      return const LoadingWidget();
                    } else if (state is GetPostsSuccessState) {
                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostDetailsScreen(
                                          postModel: state.posts[index]))),
                              child: PostCard(postModel: state.posts[index])));
                    } else {
                      return Conditional.single(
                          context: context,
                          conditionBuilder: (context) => state is NoPostsState,
                          widgetBuilder: (context) => const Center(
                                child: TxtStyle(
                                    "No Posts in this Collection Yet", 14),
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

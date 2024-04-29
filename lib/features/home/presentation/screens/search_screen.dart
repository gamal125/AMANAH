import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/loading_widget.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:amanah/features/home/application/search_cubit/search_cubit.dart';
import 'package:amanah/features/home/application/search_cubit/search_states.dart';
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
  const SearchScreen({required this.userModel, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit()..getAllPosts(),
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
                BlocBuilder<SearchCubit, SearchStates>(
                  builder: (context, state) {
                    SearchCubit searchCubit = SearchCubit.get(context);
                    return Padding(
                        padding: const EdgeInsets.only(top: 35, bottom: 40),
                        child: HeaderWidget(
                          controller: searchCubit.searchController,
                          userModel: userModel,
                          isSearching: true,
                          onChanged: ((word) {
                            searchCubit.getSearchResult(searchWord: word);
                          }),
                        ));
                  },
                ),
                const TitleWidget(title: "Search Result"),
                Expanded(child: BlocBuilder<SearchCubit, SearchStates>(
                  builder: (context, state) {
                    if (state is SearchLoadingState) {
                      return const LoadingWidget();
                    } else if (state is SearchResultLoadedState) {
                      return GridView.builder(
                          itemCount: state.posts.length,
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
                                          userModel: userModel,
                                          postModel: state.posts[index]))),
                              child: PostCard(postModel: state.posts[index])));
                    } else {
                      return Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is SearchResultEmptyState,
                          widgetBuilder: (context) => const Center(
                                child: TxtStyle(
                                    "Sorry, No Matching Data Found", 14),
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

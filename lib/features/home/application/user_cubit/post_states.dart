import 'package:amanah/features/home/data/models/post_model.dart';

abstract class PostStates {}

class PostInitialState extends PostStates {}

class PostLoadingState extends PostStates {}

class GetPostsSuccessState extends PostStates {
  final List<PostModel> posts;

  GetPostsSuccessState({required this.posts});
}

class ChangeTimeState extends PostStates {}

class CollectionChangedState extends PostStates {}

class AddPostSuccessState extends PostStates {}

class NoPostsState implements PostStates {
  final String message;
  NoPostsState(this.message);
}

class PostErrorState implements PostStates {
  final String message;
  PostErrorState(this.message);
}

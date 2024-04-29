import 'package:amanah/features/home/data/models/post_model.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState implements SearchStates {}


class SearchResultLoadedState implements SearchStates {
  List<PostModel> posts;
  SearchResultLoadedState({required this.posts});
}

class SearchResultEmptyState implements SearchStates {
  final String message;
  SearchResultEmptyState(this.message);
}

class SearchErrorState implements SearchStates {
  final String message;
  SearchErrorState(this.message);
}
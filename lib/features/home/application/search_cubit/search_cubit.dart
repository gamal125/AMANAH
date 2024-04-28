// ignore_for_file: avoid_print
import 'package:amanah/features/home/data/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  //Variables
  TextEditingController searchController = TextEditingController();
  GlobalKey<FormState> searchFormKey = GlobalKey<FormState>();

  //Methods
  Future<List<PostModel>> getSearchResult({var searchWord}) async {
    emit(SearchLoadingState());

    final locationQuery = FirebaseFirestore.instance
        .collection('posts')
        .where('currentLocation', isGreaterThanOrEqualTo: searchWord)
        .where('currentLocation', isLessThanOrEqualTo: searchWord);

    final destinationQuery = FirebaseFirestore.instance
        .collection('posts')
        .where('destination', isGreaterThanOrEqualTo: searchWord)
        .where('destination', isLessThanOrEqualTo: searchWord);

    final results = <QueryDocumentSnapshot>[];
    final queries = [locationQuery, destinationQuery];
    for (var query in queries) {
      final snapshot = await query.get();
      results.addAll(snapshot.docs);
    }

    // Filter duplicates (optional)
    final uniqueResults = results
        .toSet()
        .toList(); // Convert to set and back to list to remove duplicates

    // Convert QueryDocumentSnapshots to PostModel objects
    final postModels = uniqueResults
        .map((doc) => PostModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    if (postModels.isEmpty) {
      emit(SearchResultEmptyState("There's No Matching Data"));
    } else {
      emit(SearchResultLoadedState(posts: postModels));
    }
    return postModels;
  }
}

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
  List<PostModel> posts = [];
  bool newest = true;

  //Methods
  Future<List<PostModel>> getAllPosts() async {
    newest = !newest;
    emit(SearchLoadingState());
    List<PostModel> postModels = [];
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection('posts').get();
    if (query.docs.isNotEmpty) {
      query.docs.map<List<PostModel>>((e) {
        final data = e.data() as Map<String, dynamic>;

        final PostModel postModel = PostModel.fromMap(data);
        postModels.add(postModel);
        return postModels;
      }).toList();
      if (postModels.isEmpty) {
        posts = postModels;
        emit(SearchResultEmptyState("There's No Data Data"));
      } else {
        posts = postModels;
        newest
            ? posts.sort((a, b) => b.createdAt.compareTo(a.createdAt))
            : posts.sort((b, a) => b.createdAt.compareTo(a.createdAt));

        emit(SearchResultLoadedState(posts: postModels));
      }
      return postModels;
    }
    return postModels;
  }

  Future<List<PostModel>> getSearchResult({String? searchWord}) async {
    emit(SearchLoadingState());

    //suggestions
    final sug = posts.where((post) {
      final dynamic locationQuery, destinationQuery;

      locationQuery = post.currentLocation.toLowerCase();
      destinationQuery = post.destination.toLowerCase();

      final input = searchWord!.toLowerCase();
      return locationQuery.contains(input) || destinationQuery.contains(input);
    }).toList();
    if (sug.isNotEmpty) {
      emit(SearchResultLoadedState(posts: sug));
    } else {
      emit(SearchResultEmptyState("There's No Matching Data"));
    }

    return sug;
    //   final capitalString =
    //       searchWord![0].toUpperCase() + searchWord.substring(1);
    //   final locationQuery = FirebaseFirestore.instance
    //       .collection('posts')
    //       .where('currentLocation', isGreaterThanOrEqualTo: capitalString)
    //       .where('currentLocation', isLessThanOrEqualTo: searchWord);

    //   final destinationQuery = FirebaseFirestore.instance
    //       .collection('posts')
    //       .where('destination', isGreaterThanOrEqualTo: capitalString)
    //       .where('destination', isLessThanOrEqualTo: searchWord);

    //   final results = <QueryDocumentSnapshot>[];
    //   final queries = [locationQuery, destinationQuery];
    //   for (var query in queries) {
    //     final snapshot = await query.get();
    //     results.addAll(snapshot.docs);
    //   }

    //   // Filter duplicates (optional)
    //   final uniqueResults = results
    //       .toSet()
    //       .toList(); // Convert to set and back to list to remove duplicates

    //   // Convert QueryDocumentSnapshots to PostModel objects
    //   final postModels = uniqueResults
    //       .map((doc) => PostModel.fromMap(doc.data() as Map<String, dynamic>))
    //       .toList();

    //   if (postModels.isEmpty) {
    //     emit(SearchResultEmptyState("There's No Matching Data"));
    //   } else {
    //     emit(SearchResultLoadedState(posts: postModels));
    //   }
    //   return postModels;
    // }
  }
}

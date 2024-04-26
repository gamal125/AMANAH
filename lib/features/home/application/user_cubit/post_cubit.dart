import 'package:amanah/core/errors/custom_exception.dart';
import 'package:amanah/core/utils/functions/functions.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:amanah/features/home/application/user_cubit/post_states.dart';
import 'package:amanah/features/home/data/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostStates> {
  PostCubit() : super(PostInitialState());

  static PostCubit get(context) => BlocProvider.of(context);

// Variables
  TextEditingController descriptionController = TextEditingController();
  TextEditingController currentLocationController = TextEditingController();
  TextEditingController travelTimeController = TextEditingController();
  TextEditingController travelDateController = TextEditingController();
  TextEditingController arrivalTimeController = TextEditingController();
  TextEditingController arrivalDateController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController depthController = TextEditingController();
  TextEditingController recommendedItemsController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController availableWeightController = TextEditingController();
  TextEditingController basePriceController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController hourController = TextEditingController();
  TextEditingController minutesController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController arrdayController =
      TextEditingController(); //arr = arrival
  TextEditingController arrmonthController = TextEditingController();
  TextEditingController arryearController = TextEditingController();
  TextEditingController arrhourController = TextEditingController();
  TextEditingController arrminutesController = TextEditingController();
  TextEditingController arrtimeController = TextEditingController();
  TextEditingController othersController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  String time = "AM";
  bool isAm = true;
  GlobalKey<FormState> postFormKey = GlobalKey<FormState>();
  List<String> collections = [
    "Food",
    "Toys",
    "Electronics",
    "Cosmetics",
    "Clothing"
  ];
  String selectedCollection = "Food";
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

//methods

  Future addPost() async {
    UserModel userModel = await getDataFromSharedPref();
    travelDateController.text =
        "${dayController.text}-${monthController.text}-${yearController.text}";
    arrivalDateController.text =
        "${arrdayController.text}-${arrmonthController.text}-${arryearController.text}";
    travelTimeController.text =
        "${hourController.text}:${minutesController.text} ${timeController.text}";
    travelTimeController.text =
        "${arrhourController.text}:${arrminutesController.text} ${arrtimeController.text}";

    emit(PostLoadingState());
    //generating postID
    final postDoc = firestore.collection("posts").doc();
    final postId = postDoc.id;
    final PostModel postModel = PostModel(
        postId: postId,
        userId: userModel.userId,
        userName: userModel.firstName,
        userPhoto: userModel.personalImage,
        weight: weightController.text,
        travelDate: travelDateController.text,
        description: descriptionController.text,
        currentLocation: currentLocationController.text,
        destination: destinationController.text,
        travelTime: travelTimeController.text,
        arrivalDate: arrivalDateController.text,
        arrivalTime: arrivalTimeController.text,
        availableWeight: double.parse(availableWeightController.text),
        hieght: double.parse(heightController.text),
        width: double.parse(widthController.text),
        depth: double.parse(depthController.text),
        recommendedItemsToShip: selectedCollection,
        others: othersController.text,
        basePrice: double.parse(basePriceController.text));
    firestore
        .collection("posts")
        .doc(userModel.userId)
        .set(postModel.toMap())
        .then((value) {
      emit(AddPostSuccessState());
    }).catchError((error) {
      emit(NoPostsState(error.toString()));
      throw CustomException("Error creating user document");
    });
    return postModel;
  }

  Future getPostsByType(String collectionName) async {
    emit(PostLoadingState());
    try {
      List<PostModel> posts = [];
      QuerySnapshot query = await firestore
          .collection("posts")
          .where("recommendedItemsToShip", isEqualTo: collectionName)
          .get();

      if (query.docs.isNotEmpty) {
        query.docs.map<List<PostModel>>((e) {
          final data = e.data() as Map<String, dynamic>;

          final PostModel postModel = PostModel.fromMap(data);
          posts.add(postModel);
          return posts;
        }).toList();

        emit(GetPostsSuccessState(posts: posts));
      } else {
        emit(NoPostsState("There's No Posts Yet"));
      }
    } catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }

  //control AM PM
  void changeTime({bool arrival = false}) {
    isAm = !isAm;
    time = isAm ? "AM" : "PM";
    arrival ? arrtimeController.text = time : timeController.text = time;

    emit(ChangeTimeState());
  }

  //
  setCollection(String value) {
    selectedCollection = value;
    emit(CollectionChangedState());
  }
}

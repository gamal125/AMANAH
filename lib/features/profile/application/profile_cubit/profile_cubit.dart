// ignore_for_file: avoid_print, use_build_context_synchronously, duplicate_ignore, avoid_function_literals_in_foreach_calls
import 'dart:io';

import 'package:amanah/core/utils/functions/functions.dart';
import 'package:amanah/core/utils/widgets/dialog.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:amanah/features/profile/application/profile_cubit/profile_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  //Variables
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;
  String? profileImage;

  TextEditingController passController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();
  GlobalKey<FormState> changePassFormKey = GlobalKey<FormState>();

  //Methods

  changePassword(BuildContext context) async {
    final user = await getDataFromSharedPref();

    emit(ProfileLoadingState());
    if (oldPassController.text == user.password) {
      await firestore
          .collection("users")
          .doc(user.userId)
          .update({"password": passController.text}).then((value) async {
        user.password = passController.text;
        await storeDataLocally(user);
        passController.clear();
        confirmPassController.clear();
        oldPassController.clear();
        ShowDialog.show(context, "Password Setted", "");
        emit(ProfileChangePasswordSuccessState(user: user));
      });
    } else {
      passController.clear();
      confirmPassController.clear();
      oldPassController.clear();
      ShowDialog.show(context, "Try Again", "Wrong Old Password");
      emit(ProfileErrorState("wrong old pass"));
    }
  }

  Future<UserModel> updateProfile(UserModel userModel) async {
    final oldUser = userModel;
    final image = profileImage ?? userModel.profileImage;

    emit(ProfileLoadingState());
    if (firstNameController.text.isEmpty &&
        lastNameController.text.isEmpty &&
        countryController.text.isEmpty &&
        phoneController.text.isEmpty &&
        birthdayController.text.isEmpty &&
        profileImage == null) {
      emit(NoDataChangedState("No Data Changed"));
    } else {
      try {
        await firestore.collection("users").doc(userModel.userId).update({
          "firstName": firstNameController.text.isEmpty
              ? userModel.firstName
              : firstNameController.text,
          "lastName": lastNameController.text.isEmpty
              ? userModel.lastName
              : lastNameController.text,
          "country": countryController.text.isEmpty
              ? userModel.country
              : countryController.text,
          "dateOfBirth": birthdayController.text.isEmpty
              ? userModel.dateOfBirth
              : birthdayController.text,
          "phoneNumber": phoneController.text.isEmpty
              ? userModel.phoneNumber
              : phoneController.text,
          "profileImage": profileImage ?? userModel.profileImage
        }).then((value) {
          if (firstNameController.text.isNotEmpty || profileImage != '') {
            updateOtherCollections(oldUser, image!, firstNameController.text);
          }
          firstNameController.clear();
          lastNameController.clear();
          countryController.clear();
          birthdayController.clear();
          phoneController.clear();
          profileImage = '';
        });

        QuerySnapshot query = await firestore
            .collection("users")
            .where("userId", isEqualTo: userModel.userId)
            .get();

        query.docs.forEach((element) async {
          final data = element.data() as Map<String, dynamic>;
          UserModel user = UserModel.fromJson(data);
          await storeDataLocally(user);
          user = await getDataFromSharedPref();
          emit(ProfileUpdatedState(user: user));
        });
      } catch (e) {
        emit(ProfileErrorState(e.toString()));
      }
    }
    final user = await getDataFromSharedPref();

    return user;
  }

  updateOtherCollections(UserModel user, String prfImage, String name) async {
    //update user data in posts collection
    final QuerySnapshot query = await firestore
        .collection("posts")
        .where("userId", isEqualTo: user.userId)
        .get();

    query.docs.forEach((element) async {
      element.reference.update({
        "userName": name.isEmpty ? user.firstName : name,
        "userPhoto": prfImage == "" ? user.profileImage : prfImage
      });
    });

    //update user data in requests collection
    final QuerySnapshot requestQuery = await firestore
        .collection("requests")
        .where("travellerId", isEqualTo: user.userId)
        .get();

    requestQuery.docs.forEach((element) async {
      element.reference.update({
        "travellerName": name.isEmpty ? user.firstName : name,
        "travellerPhoto": prfImage == "" ? user.profileImage : prfImage
      });
    });
    final QuerySnapshot requestUserQuery = await firestore
        .collection("requests")
        .where("userId", isEqualTo: user.userId)
        .get();

    requestUserQuery.docs.forEach((element) async {
      element.reference.update({
        "userName": name.isEmpty ? user.firstName : name,
        "userPhoto": prfImage == "" ? user.profileImage : prfImage
      });
    });
    //update user data in notification collection
    final QuerySnapshot notificationFromQuery = await firestore
        .collection("notifications")
        .where("fromToken", isEqualTo: user.userToken)
        .get();

    notificationFromQuery.docs.forEach((element) async {
      element.reference.update({
        "fromName": name.isEmpty ? user.firstName : name,
        // "photo": prfImage == "" ? user.profileImage : prfImage
      });
    });
    final QuerySnapshot notificationToQuery = await firestore
        .collection("notifications")
        .where("toToken", isEqualTo: user.userToken)
        .get();

    notificationToQuery.docs.forEach((element) async {
      element.reference.update({
        "toName": name.isEmpty ? user.firstName : name,
        // "photo": prfImage == "" ? user.profileImage : prfImage
      });
    });
  }

  Future<File?> pickImage(BuildContext context) async {
    File? image;
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ShowDialog.show(context, "Error", "Error Picking the image $e");
    }
    return image;
  }

  changePhoto(BuildContext context, UserModel user) async {
    emit(ProfilePickingImageLoadingState());

    final imageFile = await pickImage(context);

    emit(ProfilePickImageSuccessState());
    emit(ProfileUploadingImageLoadingState());
    final String photoUrl =
        await storeFileToStorage("profileImage/${user.userId}", imageFile!);
    profileImage = photoUrl;
    emit(ProfileUploadImageSuccessState(photoUrl));
  }

  //control pass visibility
  void changePassVisibilty() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ProfileChangePassVisibiltyState());
  }
}

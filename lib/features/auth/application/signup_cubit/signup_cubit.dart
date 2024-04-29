import 'dart:io';
import 'package:amanah/core/errors/custom_exception.dart';
import 'package:amanah/core/utils/functions/functions.dart';
import 'package:amanah/core/utils/widgets/dialog.dart';
import 'package:amanah/features/auth/application/signup_cubit/signup_states.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitialState());

  static SignupCubit get(context) => BlocProvider.of(context);

//variables
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;
  bool emailVerifed = false;
  String personalImage = "";
  String idImage = "";


  String? userId;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
//methods

//get user cred
  Future signuprUser({
    String? email,
    String? password,
  }) async {
    emit(SignupLoadingState());
    firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passController.text)
        .then((value) {
      emit(SignupLoadingState());
      value.user!.sendEmailVerification();
      userId = value.user!.uid;

      if (value.user!.emailVerified == true) {
        emailVerifed = true;
      } else {
        emailVerifed = false;
      }
      emit(EmailVerifiedState());
    }).catchError((error) {
      emit(SignupErrorState(error.toString()));
    });
  }

//create user doc in firestore
  Future<UserModel> createUser() async {
    final userToken = await FirebaseMessaging.instance.getToken();
    final UserModel userModel = UserModel(
        userId: userId!,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        dateOfBirth: birthdayController.text,
        phoneNumber: phoneController.text,
        email: emailController.text,
        password: passController.text,
        country: countryController.text,
        idImage: idImage,
        personalImage: personalImage,
        userToken: userToken!);
    firestore
        .collection("users")
        .doc(userModel.userId)
        .set(userModel.toMap())
        .then((value) {
      emit(SignupSuccessState(userModel));
      storeDataLocally(userModel);
    }).catchError((error) {
      emit(SignupErrorState(error.toString()));
      throw CustomException("Error creating user document");
    });
    return userModel;
  }

//control pass visibility
  void changePassVisibilty() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SignupChangePassVisibiltyState());
  }

//picking image

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

  uploadImage(BuildContext context, bool isPassport) async {
    emit(PickingImageLoadingState());

    final imageFile = await pickImage(context);

    emit(PickingImageSuccessState());
    emit(UploadImagesLoadingState());
    final String imageUrl = await storeFileToStorage(
        isPassport ? "passportImage/$userId/" : "personalImage/$userId/",
        imageFile!);
    if (isPassport == true) {
      idImage = imageUrl;
    }
    if (isPassport == false) {
      personalImage = imageUrl;
    }
    emit(UploadImagesSuccessState(imageUrl));
  }
}

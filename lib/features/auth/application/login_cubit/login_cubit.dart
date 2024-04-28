import 'package:amanah/core/utils/functions/functions.dart';
import 'package:amanah/features/auth/application/login_cubit/login_states.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

//variables
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

//methods
  void login() async {
    emit(LoginLoadingState());
    final userToken = await FirebaseMessaging.instance.getToken();
    firebaseAuth
        .signInWithEmailAndPassword(
            email: emailController.text, password: passController.text)
        .then((value) {
      final userId = value.user!.uid;
      firestore.collection("users").doc(userId).get().then((value) {
        final UserModel userModel = UserModel.fromJson(value.data()!);
        userModel.userToken = userToken!;
        emit(LoginSuccessState(userModel));
        storeDataLocally(userModel);
      });
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  //show-hide password
  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;
  void changePassVisibilty() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(LoginChangePassVisibiltyState());
  }
}

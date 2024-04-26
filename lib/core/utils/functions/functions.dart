//store data locally
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:amanah/features/home/presentation/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

//save user's data localy
Future storeDataLocally(UserModel userModel) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  await sharedPreferences.setString(
      "user_model", jsonEncode(userModel.toMap()));
  print("data saved");
  setSignin();
}

//get user's local data
Future<UserModel> getDataFromSharedPref() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sharedPreferences.reload();
  String data = sharedPreferences.getString("user_model") ?? '';
  final userModel = UserModel.fromJson(jsonDecode(data));
  return userModel;
}

//save login
Future setSignin() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sharedPreferences.setBool("is_signed_in", true);
  print("user login saved");
}

//logout
Future signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sharedPreferences.setBool("is_signed_in", false);
  // ignore: use_build_context_synchronously
  Navigator.pushAndRemoveUntil(
    // ignore: use_build_context_synchronously
    context,
    MaterialPageRoute(builder: (context) => const SplashScreen()),
    (Route<dynamic> route) => false,
  );
}

//store photo file to storage and get downloadUrl -downloadUrl is used to open the photo in the app
Future<String> storeFileToStorage(String ref, File file) async {
  UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();

  return downloadUrl;
}

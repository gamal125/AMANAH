import 'package:amanah/features/auth/data/models/user_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}


class LoginSuccessState extends LoginStates {
  final UserModel userModel;
  LoginSuccessState(this.userModel);
}

class UserNotFoundState extends LoginStates {}

class LoginErrorState implements LoginStates {
  final String message;
  LoginErrorState(this.message);
}

class LoginChangePassVisibiltyState extends LoginStates {}
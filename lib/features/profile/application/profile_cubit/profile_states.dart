import 'package:amanah/features/auth/data/models/user_model.dart';

abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState implements ProfileStates {}

class ProfileUpdatedState implements ProfileStates {
  final UserModel user;

  ProfileUpdatedState({required this.user});
}

class ProfileChangePasswordSuccessState implements ProfileStates {
  final UserModel user;

  ProfileChangePasswordSuccessState({required this.user});
}

class ProfilePickingImageLoadingState implements ProfileStates {}

class ProfilePickImageSuccessState implements ProfileStates {}

class ProfileUploadingImageLoadingState implements ProfileStates {}

class ProfileUploadImageSuccessState implements ProfileStates {
  final String imageurl;
  ProfileUploadImageSuccessState(this.imageurl);
}

class ProfileChangePassVisibiltyState implements ProfileStates{}
class NoDataChangedState implements ProfileStates {
  final String message;
  NoDataChangedState(this.message);
}

class ProfileErrorState implements ProfileStates {
  final String message;
  ProfileErrorState(this.message);
}

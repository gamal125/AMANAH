import 'package:amanah/features/auth/data/models/user_model.dart';

abstract class SignupStates {}

class SignupInitialState extends SignupStates {}

class SignupLoadingState extends SignupStates {}

class SignupSuccessState extends SignupStates {
  final UserModel userModel;
  SignupSuccessState(this.userModel);
}

class EmailVirificationSent extends SignupStates {}

class VerifiyEmailState extends SignupStates {}

class PickingImageLoadingState extends SignupStates {}

class PickingImageSuccessState extends SignupStates {}

class UploadImagesLoadingState extends SignupStates {}

class UploadImagesErrorState extends SignupStates {}

class UploadImagesSuccessState extends SignupStates {
  final String imageurl;
  UploadImagesSuccessState(this.imageurl);
}

class SignupChangePassVisibiltyState extends SignupStates {}

class EmailVerifiedState extends SignupStates {}

class SignupErrorState implements SignupStates {
  final String message;
  SignupErrorState(this.message);
}

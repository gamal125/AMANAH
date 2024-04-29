class UserModel {
  String userId;
  String firstName;
  String lastName;
  String dateOfBirth;
  String phoneNumber;
  String email;
  String password;
  String country;
  String idImage;
  String? profileImage;
  bool isShipping;
  String userToken;
  String personalImage;

  UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.country,
    required this.idImage,
     this.profileImage =  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png",
    required this.userToken,
    required this.personalImage,
    this.isShipping = false,
  });

  //from map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userId: json['userId'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        dateOfBirth: json['dateOfBirth'] as String,
        email: json['email'] as String,
        phoneNumber: json['phoneNumber'] as String,
        country: json['country'] as String,
        password: json['password'] as String,
        idImage: json['idImage'] as String,
        isShipping: json['isShipping'] as bool,
        profileImage: json['profileImage'] as String,
        personalImage: json['personalImage'] as String,
        userToken: json['userToken'] as String);
  }

  //to map
  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "userId": userId,
      "phoneNumber": phoneNumber,
      "email": email,
      "password": password,
      "dateOfBirth": dateOfBirth,
      "country": country,
      "idImage": idImage,
      "profileImage": profileImage,
      "isShipping": isShipping,
      'userToken': userToken,
      'personalImage': personalImage
    };
  }
}

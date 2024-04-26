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
  String personalImage;
  bool isShipping;
  // List<Activity> listOfActivities;
  // List<Notification> listOfNotifications;
  // List<Payment> listOfPayments;
  // List<Request> listOfRequests;

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
    required this.personalImage,
     this.isShipping = false,
    // required this.listOfActivities,
    // required this.listOfNotifications,
    // required this.listOfPayments,
    // required this.listOfRequests,
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
        personalImage: json['personalImage'] as String);
  }

  //to map
  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName" : lastName,
      "userId": userId,
      "phoneNumber": phoneNumber,
      "email": email,
      "password": password,
      "dateOfBirth": dateOfBirth,
      "country": country,
      "idImage" : idImage,
      "personalImage": personalImage,
      "isShipping" : isShipping,
    };
  }
}

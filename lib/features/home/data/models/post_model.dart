// ignore_for_file: public_member_api_docs, sort_constructors_first

class PostModel {
  String postId;
  String userId;
  String userToken;
  String weight;
  String description;
  String currentLocation;
  String destination;
  String travelTime;
  String travelDate;
  String arrivalDate;
  String arrivalTime;
  double availableWeight;
  double hieght;
  double width;
  double depth;
  double rate;
  String recommendedItemsToShip;
  double basePrice;
  String userName;
  String userPhoto;
  String userPhone;
  String? others;
  DateTime createdAt;
  PostModel(
      {required this.postId,
      required this.userToken,
      required this.weight,
      required this.userName,
      required this.userPhoto,
      required this.userId,
      required this.travelDate,
      required this.description,
      required this.currentLocation,
      required this.destination,
      required this.travelTime,
      required this.arrivalDate,
      required this.arrivalTime,
      required this.availableWeight,
      required this.hieght,
      required this.width,
      required this.depth,
      required this.userPhone,
      required this.recommendedItemsToShip,
      required this.basePrice,
        required this.rate,
      required this.createdAt,
      this.others = ''});

  //to map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      "createdAt": createdAt.toIso8601String(),
      'userToken': userToken,
      'userId': userId,
      "weight": weight,
      'description': description,
      'currentLocation': currentLocation,
      'destination': destination,
      'travelTime': travelTime,
      'arrivalDate': arrivalDate,
      'arrivalTime': arrivalTime,
      'availableWeight': availableWeight,
      'depth': depth,
      "userPhone" : userPhone,
      'hieght': hieght,
      'width': width,
      'rate': rate,
      'recommendedItemsToShip': recommendedItemsToShip,
      'basePrice': basePrice,
      "travelDate": travelDate,
      'userName': userName,
      'userPhoto': userPhoto,
      'others': others
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      postId: map['postId'] as String,
      userId: map['userId'] as String,
      weight: map['weight'] as String,
      createdAt: DateTime.tryParse(map['createdAt'])!,
      userToken: map['userToken'] as String,
      userName: map['userName'] as String,
      userPhoto: map['userPhoto'] as String,
      description: map['description'],
      userPhone: map['userPhone'] as String,
      currentLocation: map['currentLocation'] as String,
      destination: map['destination'] as String,
      travelTime: map['travelTime'] as String,
      travelDate: map['travelDate'] as String,
      arrivalDate: map['arrivalDate'] as String,
      arrivalTime: map['arrivalTime'] as String,
      availableWeight: map['availableWeight'] as double,
      hieght: map['hieght'] as double,
      depth: map['depth'] as double,
      rate: map['rate'] as double,
      width: map['width'] as double,
      others: map['others'],
      recommendedItemsToShip: map['recommendedItemsToShip'] as String,
      basePrice: map['basePrice'] as double,
    );
  }
}

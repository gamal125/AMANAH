class RequestModel {
  String requestId;
  String description;
  String userId;
  String travellerId;
  String userToken;
  String travellerToken;
  String postId;
  String userName;
  String travellerName;
  String travellerPhoto;
  String userPhoto;
  String recommendedItemsToShip;
  String from;
  String to;
  String userPhone;
  DateTime date;
  String status;
  double weight;
  double height;
  double width;
  double depth;
  double rate;
  double itemPrice;
  double extraSize;
  double distanceFees;
  double moreSafety;
  double lastPrice;
  double extraWeight;

  RequestModel(
      {required this.requestId,
      required this.travellerName,
      required this.from,
      required this.to,
      required this.recommendedItemsToShip,
      required this.userName,
      required this.postId,
      required this.userId,
      required this.travellerPhoto,
      required this.userPhoto,
      required this.travellerId,
      required this.description,
      required this.date,
      required this.status,
      required this.weight,
      required this.height,
      required this.width,
        required this.rate,
      required this.depth,
      required this.itemPrice,
      required this.userToken,
      required this.travellerToken,
      required this.userPhone,
      this.extraSize = 0.0,
      this.distanceFees = 0.0,
      this.moreSafety = 0.0,
      this.lastPrice = 0.0,
      this.extraWeight = 0.0});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestId': requestId,
      "recommendedItemsToShip": recommendedItemsToShip,
      "from": from,
      "to": to,
      'userPhone': userPhone,
      "userToken": userToken,
      "travellerToken": travellerToken,
      "travellerId": travellerId,
      "travellerName": travellerName,
      "travellerPhoto": travellerPhoto,
      "userPhoto": userPhoto,
      "userName": userName,
      'postId': postId,
      'userId': userId,
      'rate': rate,
      'description': description,
      'date': date.toIso8601String(),
      'status': status,
      'weight': weight,
      'height': height,
      'width': width,
      'depth': depth,
      'itemPrice': itemPrice,
      'extraSize': extraSize,
      'distanceFees': distanceFees,
      'moreSafety': moreSafety,
      'lastPrice': lastPrice,
      'extraWeight': extraWeight
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
        recommendedItemsToShip: map['recommendedItemsToShip'] as String,
        from: map['from'] as String,
        to: map['to'] as String,
        userPhone: map['userPhone'] as String,
        travellerToken: map['travellerToken'] as String,
        userToken: map["userToken"] as String,
        requestId: map['requestId'] as String,
        postId: map['postId'] as String,
        userPhoto: map['userPhoto'] as String,
        travellerPhoto: map['travellerPhoto'] as String,
        travellerId: map['travellerId'] as String,
        userId: map['userId'] as String,
        description: map['description'] as String,
        date: DateTime.tryParse(map['date'])!,
        status: map['status'] as String,
        weight: map['weight'] as double,
        height: map['height'] as double,
        width: map['width'] as double,
        rate: map['rate'] as double,
        depth: map['depth'] as double,
        itemPrice: map['itemPrice'] as double,
        extraSize: map['extraSize'] as double,
        distanceFees: map['distanceFees'] as double,
        moreSafety: map['moreSafety'] as double,
        lastPrice: map['lastPrice'] as double,
        travellerName: map["travellerName"] as String,
        extraWeight: map['extraWeight'] as double,
        userName: map['userName'] as String);
  }
}

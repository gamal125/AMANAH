// ignore_for_file: public_member_api_docs, sort_constructors_first

class NotificationModel {
  String notificationId;
  String notificationBody;
  String notificationTitle;
  String fromName;
  String toName;
  String fromToken;
  String toToken;
  String photo;
  String userId;
  DateTime createdAt;
  NotificationModel(
      {required this.notificationId,
      required this.notificationBody,
      required this.notificationTitle,
      required this.fromName,
      required this.toName,
      required this.fromToken,
      required this.toToken,
      required this.createdAt,
      required this.photo,
      required this.userId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notificationId': notificationId,
      'notificationBody': notificationBody,
      'notificationTitle': notificationTitle,
      'fromName': fromName,
      'toName': toName,
      'fromToken': fromToken,
      'toToken': toToken,
      'createdAt': createdAt.toIso8601String(),
      'photo': photo,
      "userId": userId
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
        notificationId: map['notificationId'] as String,
        notificationBody: map['notificationBody'] as String,
        notificationTitle: map['notificationTitle'] as String,
        fromName: map['fromName'] as String,
        toName: map['toName'] as String,
        fromToken: map['fromToken'] as String,
        toToken: map['toToken'] as String,
        createdAt: DateTime.tryParse(map['createdAt'])!,
        userId: map['userId'] as String,
        photo: map['photo']);
  }
}

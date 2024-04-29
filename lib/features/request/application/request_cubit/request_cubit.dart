// ignore_for_file: avoid_print

// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:amanah/features/request/data/models/notification_model.dart';
import 'package:http/http.dart' as http;
import 'package:amanah/core/utils/functions/functions.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:amanah/features/home/data/models/post_model.dart';
import 'package:amanah/features/request/application/request_cubit/request_states.dart';
import 'package:amanah/features/request/data/models/request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/custom_exception.dart';

class RequestCubit extends Cubit<RequestStates> {
  RequestCubit() : super(RequestInitialState());

  static RequestCubit get(context) => BlocProvider.of(context);

  /// request status:
  ///sent = when user send a request
  ///setPayment = when traveller set payment data
  ///inProgress = when user accept payment data
  ///rejected = when both reject the request
  ///travellerReject = when traveller reject request
  ///
// Variables

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController descriptionController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  TextEditingController depthController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  GlobalKey<FormState> requestFormKey = GlobalKey<FormState>();
  String currentUserId = "";
  int extraWeight = 0;
  int extraSize = 0;
  int moreSafety = 0;
  int distanceFees = 0;
  int lastPrice = 0;
  int counter = 0;
  List<Counter> counters = [
    Counter("Extra Wieght", 0),
    Counter("Extra Size", 0),
    Counter("Distance Fees", 0),
    Counter("More Safety", 0),
  ];

  void increment(int index) {
    counters[index].count++;
    if (index == 0) {
      extraWeight = counters[index].count;
    } else if (index == 1) {
      extraSize = counters[index].count;
    } else if (index == 2) {
      distanceFees = counters[index].count;
    } else if (index == 3) {
      moreSafety = counters[index].count;
    }

    updateLastPrice();
    emit(CounterChangedState());
  }

  void decrement(int index) {
    if (counters[index].count > 0) {
      counters[index].count--;
      if (index == 0) {
        extraWeight = counters[index].count;
      } else if (index == 1) {
        extraSize = counters[index].count;
      } else if (index == 2) {
        distanceFees = counters[index].count;
      } else if (index == 3) {
        moreSafety = counters[index].count;
      }

      updateLastPrice();
    }
    emit(CounterChangedState());
  }

  void updateLastPrice() {
    lastPrice = counters.fold(0, (summ, counter) => summ + counter.count);
  }

  //create send req method
  addRequest(UserModel userModel, PostModel postModel) async {
    //send notification to TRAVELLER when user request a post
    //generating ID
    emit(RequestLoadingState());
    final requestDoc = firestore.collection("requests").doc();
    final requestId = requestDoc.id;
    final RequestModel requestModel = RequestModel(
        requestId: requestId,
        userToken: userModel.userToken,
        travellerToken: postModel.userToken,
        postId: postModel.postId,
        userId: userModel.userId,
        travellerId: postModel.userId,
        travellerName: postModel.userName,
        userName: userModel.firstName,
        userPhoto: userModel.profileImage!,
        travellerPhoto: postModel.userPhoto,
        description: descriptionController.text,
        from: postModel.currentLocation,
        to: postModel.destination,
        recommendedItemsToShip: postModel.recommendedItemsToShip,
        date: DateTime.now(),
        status: "sent",
        weight: double.parse(weightController.text),
        height: double.parse(heightController.text),
        width: double.parse(widthController.text),
        depth: double.parse(depthController.text),
        itemPrice: double.parse(itemPriceController.text));

    firestore
        .collection("requests")
        .doc(requestId)
        .set(requestModel.toMap())
        .then((value) async {
      final notificationBody =
          "Your flight to ${requestModel.to} has been requested";
      final notificationDoc = firestore.collection("notifications").doc();
      final notificationId = notificationDoc.id;
      NotificationModel notificationModel = NotificationModel(
          notificationId: notificationId,
          userId: requestModel.travellerId,
          notificationBody: notificationBody,
          notificationTitle: "New Request",
          fromName: requestModel.userName,
          toName: requestModel.travellerName,
          fromToken: requestModel.userToken,
          toToken: requestModel.travellerToken,
          createdAt: DateTime.now(),
          photo: requestModel.userPhoto);
      await firestore
          .collection('notifications')
          .doc(notificationId)
          .set(notificationModel.toMap());
      sendPushMessage(
          notificationBody, "New Request", requestModel.travellerToken);
      emit(AddRequestSuccessState());
    }).catchError((error) {
      emit(NoRequestsState(error.toString()));
      throw CustomException("Error Sending Request");
    });
    return requestModel;
  }

  //show the requests in activity screen
  getRequests() async {
    emit(RequestLoadingState());
    UserModel userModel = await getDataFromSharedPref();
    currentUserId = userModel.userId;
    try {
      List<RequestModel> requests = [];
      QuerySnapshot query = await firestore
          .collection("requests")
          .orderBy("date", descending: true)
          .get();

      if (query.docs.isNotEmpty) {
        query.docs.map<List<RequestModel>>((e) {
          final data = e.data() as Map<String, dynamic>;

          final RequestModel requestModel = RequestModel.fromMap(data);
          requests.add(requestModel);
          return requests;
        }).toList();

        emit(GetRequestsState(requests));
      } else {
        emit(NoRequestsState("There's No Requests Yet"));
      }
    } catch (e) {
      emit(RequestErrorState(e.toString()));
    }
  }

  //get request after update
  getOneRequest(String requestId) async {
    emit(RequestLoadingState());
    UserModel userModel = await getDataFromSharedPref();
    RequestModel? requestModel;
    currentUserId = userModel.userId;
    try {
      QuerySnapshot query = await firestore
          .collection("requests")
          .where("requestId", isEqualTo: requestId)
          .get();
      query.docs.forEach((element) async {
        final data = element.data() as Map<String, dynamic>;
        requestModel = RequestModel.fromMap(data);
        emit(GetOneRequestState(requestModel!));
      });
    } catch (e) {
      emit(RequestErrorState(e.toString()));
    }
    return requestModel!;
  }

  //add payments data
  Future addPaymentData(RequestModel requestModel) async {
//send notification to USER from TRAVELLER who added the payment data
    emit(AddPaymentDataLoadingState());
    requestModel.extraSize = extraSize.toDouble();
    requestModel.extraWeight = extraWeight.toDouble();
    requestModel.distanceFees = distanceFees.toDouble();
    requestModel.moreSafety = moreSafety.toDouble();
    requestModel.lastPrice = lastPrice.toDouble();

    await firestore.collection("requests").doc(requestModel.requestId).update({
      "extraWeight": extraWeight.toDouble(),
      "distanceFees": distanceFees.toDouble(),
      "extraSize": extraSize.toDouble(),
      "moreSafety": moreSafety.toDouble(),
      "lastPrice": lastPrice.toDouble(),
      "status": 'set payment'
    }).then((value) async {
      final notificationBody =
          "${requestModel.travellerName} setted payment data";
      final notificationDoc = firestore.collection("notifications").doc();
      final notificationId = notificationDoc.id;
      NotificationModel notificationModel = NotificationModel(
          notificationId: notificationId,
          userId: requestModel.userId,
          notificationBody: notificationBody,
          notificationTitle: "Check Payment Data",
          fromName: requestModel.travellerName,
          toName: requestModel.userName,
          fromToken: requestModel.travellerToken,
          toToken: requestModel.userToken,
          createdAt: DateTime.now(),
          photo: requestModel.travellerPhoto);
      await firestore
          .collection('notifications')
          .doc(notificationId)
          .set(notificationModel.toMap());
      sendPushMessage(
          notificationBody, "Check Payment Data", requestModel.userToken);
    });
    emit(AddPaymentDataSuccessState());
  }

  Future updateRequestStatue(RequestModel requestModel, String status) async {
    //when status will set to == inProgress send notification to TRAVELLER form USER
    //else there is no notifications to send for both
    final UserModel user = await getDataFromSharedPref();

    emit(RequestLoadingState());
    await firestore
        .collection("requests")
        .doc(requestModel.requestId)
        .update({"status": status}).then((value) async {
      if (status == "inProgress") {
        final notificationBody =
            "${requestModel.userName} accepted payment data";
        final notificationDoc = firestore.collection("notifications").doc();
        final notificationId = notificationDoc.id;
        NotificationModel notificationModel = NotificationModel(
            notificationId: notificationId,
            notificationBody: notificationBody,
            userId: requestModel.travellerId,
            notificationTitle: "Request is in progress",
            fromName: requestModel.userName,
            toName: requestModel.travellerName,
            fromToken: requestModel.userToken,
            toToken: requestModel.travellerToken,
            createdAt: DateTime.now(),
            photo: requestModel.userPhoto);
        await firestore
            .collection('notifications')
            .doc(notificationId)
            .set(notificationModel.toMap());
        sendPushMessage(notificationBody, "Request is in progress",
            requestModel.travellerToken);
      }
    });
    emit(UpdateRequestStatusSuccessState());
    return user;
  }

  Future deleteRequest(
      RequestModel requestModel, bool isUserDeletedRequest) async {
    //send notification to TRAVELLER if USER deleted the request - isUserDeletedRequest = true
    //send notification to USER if TRAVELLER deleted the request - isUserDeletedRequest = false

    emit(RequestLoadingState());
    final UserModel user = await getDataFromSharedPref();
    await firestore
        .collection("requests")
        .doc(requestModel.requestId)
        .delete()
        .then((v) async {
      final notificationBody = isUserDeletedRequest
          ? "${requestModel.userName} rejected payment data"
          : "${requestModel.travellerName} rejected the request";
      final notificationDoc = firestore.collection("notifications").doc();
      final notificationId = notificationDoc.id;
      NotificationModel notificationModel = NotificationModel(
          notificationId: notificationId,
          notificationBody: notificationBody,
          notificationTitle: "Request Deleted",
          userId: isUserDeletedRequest
              ? requestModel.travellerId
              : requestModel.userId,
          fromName: isUserDeletedRequest
              ? requestModel.userName
              : requestModel.travellerName,
          toName: isUserDeletedRequest
              ? requestModel.travellerName
              : requestModel.userName,
          fromToken: isUserDeletedRequest
              ? requestModel.userToken
              : requestModel.travellerToken,
          toToken: isUserDeletedRequest
              ? requestModel.travellerToken
              : requestModel.userToken,
          createdAt: DateTime.now(),
          photo: isUserDeletedRequest
              ? requestModel.userPhoto
              : requestModel.travellerPhoto);
      await firestore
          .collection('notifications')
          .doc(notificationId)
          .set(notificationModel.toMap());
      sendPushMessage(
          notificationBody,
          "Request Deleted",
          isUserDeletedRequest
              ? requestModel.travellerToken
              : requestModel.userToken);
    });
    emit(DeleteRequestSuccessState());
    return user;
  }

  //show updated req for both in activity
  //handle confirm and delete actions
  //add notifications
}

void sendPushMessage(String body, String title, String token) async {
  try {
    final res = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAY4thjKQ:APA91bE1JafehjbwGBP6HnD3MtHAQmck5d_EJnQANsmQfJIJuwxAzhepLxFqgc_NVlLg0S_sSeObeTNRi3jfd8r7Ejq9MouSUL_XxeqKCCsEtfD2FiZnOTD8Jm6suGeDoo5Ah7bESCo4',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': title,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          "to": token
          // "to":
          //     "fJOL8pvMTtymdgS7n8H5EH:APA91bHGLOvK4oVgVLnFeGKHewFeYMSUX_RthusfmR4P1Pw-7d_teMyelHebt8Urc_oLp7dO0_H-kaYB1Ow2bz7Yfqz5Ua6EBUC74Qzfimmqwtu9MGtZzNprzACnBjZp66jxdMCYVv46",
        },
      ),
    );
    if (res.statusCode == 200) {
      print('done');
    } else {
      print("s");
    }
  } catch (e) {
    print("error push notification");
  }
}

class Counter {
  int count = 0;
  String label;

  Counter(this.label, this.count);
}

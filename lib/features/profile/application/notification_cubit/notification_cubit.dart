// ignore_for_file: avoid_print
import 'package:amanah/core/errors/custom_exception.dart';
import 'package:amanah/core/utils/functions/functions.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:amanah/features/request/data/models/notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_states.dart';

class NotificationCubit extends Cubit<NotificationStates> {
  NotificationCubit() : super(NotificationInitialState());

  static NotificationCubit get(context) => BlocProvider.of(context);

  //Variables
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Methods
  Future getNotifications() async {
    emit(NotificationLoadingState());
    final UserModel userModel = await getDataFromSharedPref();
    try {
      List<NotificationModel> notifications = [];
      QuerySnapshot query = await firestore
          .collection("notifications")
          .where("userId", isEqualTo: userModel.userId)
          .get();

      if (query.docs.isNotEmpty) {
        query.docs.map<List<NotificationModel>>((e) {
          final data = e.data() as Map<String, dynamic>;

          final NotificationModel notificationModel =
              NotificationModel.fromMap(data);
          notifications.add(notificationModel);
          return notifications;
        }).toList();

        emit(NotificationLoadedState(notifications: notifications));
      } else {
        emit(NoNotificationState("There's No Notifications Yet"));
        return notifications;
      }
    } catch (e) {
      emit(NotificationErrorState(e.toString()));
      throw CustomException("Error Getting Notifications");
    }
  }
}

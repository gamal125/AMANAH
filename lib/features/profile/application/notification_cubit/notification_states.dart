import 'package:amanah/features/request/data/models/notification_model.dart';

abstract class NotificationStates {}

class NotificationInitialState extends NotificationStates {}

class NotificationLoadingState implements NotificationStates {}

class NotificationLoadedState implements NotificationStates {
  List<NotificationModel> notifications;
  NotificationLoadedState({required this.notifications});
}
class NoNotificationState implements NotificationStates {
  final String message;
  NoNotificationState(this.message);
}
class NotificationErrorState implements NotificationStates {
  final String message;
  NotificationErrorState(this.message);
}

import 'package:amanah/features/request/data/models/request_model.dart';

abstract class RequestStates {}

class RequestInitialState extends RequestStates {}

class RequestLoadingState extends RequestStates {}

class AddRequestSuccessState extends RequestStates {}

class GetRequestsState extends RequestStates {
  final List<RequestModel> requests;
  GetRequestsState(this.requests);
}
class GetOneRequestState extends RequestStates {
  final RequestModel request;
  GetOneRequestState(this.request);
}
class NoRequestsState implements RequestStates {
  final String message;
  NoRequestsState(this.message);
}

class UpdateRequestStatusSuccessState extends RequestStates {}

class DeleteRequestSuccessState extends RequestStates {}

class AddPaymentDataLoadingState extends RequestStates {}

class AddPaymentDataSuccessState extends RequestStates {}

class AddPaymentDataErrorState extends RequestStates {
  final String message;
  AddPaymentDataErrorState(this.message);
}

class CounterChangedState extends RequestStates {}

class IncreaseState extends RequestStates {
  final int number;
  IncreaseState({required this.number});
}

class DecreaseState extends RequestStates {
  final int number;
  DecreaseState({required this.number});
}

class RequestErrorState implements RequestStates {
  final String message;
  RequestErrorState(this.message);
}

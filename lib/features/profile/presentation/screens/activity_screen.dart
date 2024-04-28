import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/dialog.dart';
import 'package:amanah/core/utils/widgets/loading_widget.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:amanah/features/profile/presentation/widgets/activity_card.dart';
import 'package:amanah/features/request/application/request_cubit/request_cubit.dart';
import 'package:amanah/features/request/application/request_cubit/request_states.dart';
import 'package:amanah/features/request/presentation/screens/confirm_screen.dart';
import 'package:amanah/features/request/presentation/screens/in_progress_screen.dart';
import 'package:amanah/features/request/presentation/screens/traveller_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivityScreen extends StatelessWidget {
  final UserModel user;
  const ActivityScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestCubit()..getRequests(),
      child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios, color: secondary)),
          ),
          body: SingleChildScrollView(
              child: BlocBuilder<RequestCubit, RequestStates>(
            builder: (context, state) {
              RequestCubit requestCubit = RequestCubit.get(context);
              if (state is GetRequestsState) {
                return Column(
                  children: [
                    const TxtStyle("Activities", 36,
                        fontWeight: FontWeight.bold),
                    SizedBox(height: 70.h),
                    ...state.requests
                        .map((request) => request.status == "rejected"
                            ? SizedBox()
                            : GestureDetector(
                                onTap: requestCubit.currentUserId ==
                                            request.travellerId &&
                                        request.status == "sent"
                                    ? () {
                                        //traveller => go and set payment and accept or reject there
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider.value(
                                                      value: requestCubit,
                                                      child:
                                                          TravellerRequestScreen(
                                                              requestModel:
                                                                  request,
                                                              requestCubit:
                                                                  requestCubit,
                                                              user: user),
                                                    )));
                                      }
                                    : requestCubit.currentUserId ==
                                                request.travellerId &&
                                            request.status == "setPayment"
                                        ? () {
                                            //traveller => do nothing
                                            ShowDialog.show(
                                                context,
                                                "Payment Setted",
                                                "Wait for the confirmation");
                                          }
                                        : requestCubit.currentUserId !=
                                                    request.travellerId &&
                                                request.status == "sent"
                                            ? () {
                                                //user => do nothing
                                                print(request.userId);
                                                print(request.travellerId);
                                                ShowDialog.show(
                                                    context,
                                                    "Request Sent",
                                                    "Wait traveller to set payment");
                                              }
                                            : requestCubit.currentUserId !=
                                                        request.travellerId &&
                                                    request.status ==
                                                        "setPayment"
                                                ? () {
                                                    //user => accept or reject
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    BlocProvider
                                                                        .value(
                                                                      value:
                                                                          requestCubit,
                                                                      child: ConfirmScreen(
                                                                          requestModel:
                                                                              request,
                                                                          requestCubit:
                                                                              requestCubit),
                                                                    )));
                                                  }
                                                : request.status == "inProgress"
                                                    ? () {
                                                        //i thnk both should go to in progress screen
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    InProgressScreen(
                                                                        requestModel:
                                                                            request,
                                                                        user:
                                                                            user)));
                                                      }
                                                    : () {},
                                child: ActivityCard(requestModel: request)))
                        .toList(),
                  ],
                );
              } else {
                return Conditional.single(
                    context: context,
                    conditionBuilder: (context) =>
                        state is! RequestLoadingState,
                    fallbackBuilder: (context) => LoadingWidget(),
                    widgetBuilder: (context) => Column(
                          children: [
                            const TxtStyle("Activities", 36,
                                fontWeight: FontWeight.bold),
                            SizedBox(height: 70.h),
                            Center(
                                child:
                                    TxtStyle("There's No Activities Yet", 14)),
                          ],
                        ));
              }
            },
          ))),
    );
  }
}

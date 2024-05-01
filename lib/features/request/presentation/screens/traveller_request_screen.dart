import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/custom_button.dart';
import 'package:amanah/core/utils/widgets/dialog.dart';
import 'package:amanah/core/utils/widgets/loading_widget.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:amanah/features/home/presentation/screens/home_screen.dart';
import 'package:amanah/features/request/application/request_cubit/request_cubit.dart';
import 'package:amanah/features/request/application/request_cubit/request_states.dart';
import 'package:amanah/features/request/data/models/request_model.dart';
import 'package:amanah/features/request/presentation/screens/in_progress_screen.dart';
import 'package:amanah/features/request/presentation/widgets/request_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TravellerRequestScreen extends StatelessWidget {
  final RequestModel requestModel;
  final RequestCubit requestCubit;
  final UserModel user;
  const TravellerRequestScreen(
      {required this.requestModel,
      required this.requestCubit,
      required this.user,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<RequestCubit>(context),
      child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios, color: secondary)),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SingleChildScrollView(
              child: BlocBuilder<RequestCubit, RequestStates>(
                builder: (context, state) {
                  return Column(children: [
                    const TxtStyle("Request", 36, fontWeight: FontWeight.bold),
                    Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 20),
                        child: RequestWidget(requestModel: requestModel)),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: TxtStyle("Extra Services", 24,
                            fontWeight: FontWeight.bold)),

                    Row(
                      children: [
                        SizedBox(width: 30.w),
                        Expanded(
                          child: Column(children: [
                            BlocBuilder<RequestCubit, RequestStates>(
                              builder: (context, state) {
                                return SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                      itemCount: requestCubit.counters.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TxtStyle(
                                                  requestCubit
                                                      .counters[index].label,
                                                  16,
                                                  color: secondarySoft),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      requestCubit
                                                          .increment(index);
                                                    },
                                                    child: const CircleAvatar(
                                                        radius: 12,
                                                        backgroundColor:
                                                            primary,
                                                        child: Center(
                                                            child: Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .white))),
                                                  ),
                                                  TxtStyle(
                                                      " ${requestCubit.counters[index].count} ",
                                                      20),
                                                  GestureDetector(
                                                    onTap: () {
                                                      requestCubit
                                                          .decrement(index);
                                                    },
                                                    child: const CircleAvatar(
                                                        radius: 12,
                                                        backgroundColor:
                                                            primary,
                                                        child: Icon(
                                                            Icons.remove,
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ],
                                              ),
                                            ]);
                                      }),
                                );
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TxtStyle("\nTotal:", 20,
                                    fontWeight: FontWeight.bold,
                                    color: secondarySoft),
                                TxtStyle("\n${requestCubit.lastPrice}\$", 20,
                                    fontWeight: FontWeight.bold,
                                    color: secondarySoft),
                              ],
                            ),
                          ]),
                        ),
                        SizedBox(width: 30.w),
                      ],
                    ),
                    // const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<RequestCubit, RequestStates>(
                            builder: (context, state) {
                          RequestCubit requestCubit = RequestCubit.get(context);
                          if (state is RequestLoadingState) {
                            return const LoadingWidget();
                          } else {
                            return CustomButton(
                              text: "Confirm",
                              width: 180,
                              onPressed: () {
                                requestCubit
                                    .addPaymentData(requestModel)
                                    .then((value) =>
                                        requestCubit.updateRequestStatue(
                                            requestModel, "setPayment"))
                                    .then((value) => requestCubit
                                        .getOneRequest(requestModel.requestId))
                                    .then((value) {
                                  return Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InProgressScreen(
                                                  requestModel: value,
                                                  user: user)));
                                }).catchError((e) => ShowDialog.show(
                                        context, "Faild", e.toString()));
                              },
                            );
                          }
                        }),
                        BlocBuilder<RequestCubit, RequestStates>(
                          builder: (context, state) {
                            RequestCubit requestCubit =
                                RequestCubit.get(context);
                            if (state is RequestLoadingState) {
                              return const LoadingWidget();
                            } else {
                              return CustomButton(
                                text: "Delete",
                                width: 180,
                                isDelete: true,
                                onPressed: () {
                                  requestCubit
                                      .deleteRequest(requestModel, false)
                                      .then((value) =>
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen(user: user)),
                                              (Route<dynamic> route) => false))
                                      .catchError((e) => ShowDialog.show(
                                          context, "Faild", e.toString()));
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h)
                  ]);
                },
              ),
            ),
          )),
    );
  }
}

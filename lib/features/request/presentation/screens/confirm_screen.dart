import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/custom_button.dart';
import 'package:amanah/core/utils/widgets/loading_widget.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/home/presentation/screens/home_screen.dart';
import 'package:amanah/features/request/application/request_cubit/request_cubit.dart';
import 'package:amanah/features/request/application/request_cubit/request_states.dart';
import 'package:amanah/features/request/data/models/request_model.dart';
import 'package:amanah/features/request/presentation/screens/in_progress_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/widgets/dialog.dart';

class ConfirmScreen extends StatelessWidget {
  final RequestModel requestModel;
  final RequestCubit requestCubit;
  const ConfirmScreen(
      {required this.requestModel, required this.requestCubit, super.key});

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
          body: Column(children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TxtStyle("Confirm Payment Data", 33,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: primary)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        CircleAvatar(
                            minRadius: 20,
                            maxRadius: 20,
                            backgroundImage:
                                NetworkImage(requestModel.travellerPhoto)),
                        TxtStyle("  ${requestModel.travellerName}", 24,
                            fontWeight: FontWeight.bold)
                      ]),
                      const TxtStyle("\nExtra Services", 24,
                          fontWeight: FontWeight.bold),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TxtStyle("\nExtra Wieght", 16,
                                    fontWeight: FontWeight.bold,
                                    color: secondarySoft),
                                TxtStyle("Extra Size", 16,
                                    fontWeight: FontWeight.bold,
                                    color: secondarySoft),
                                TxtStyle("Distance Fees", 16,
                                    fontWeight: FontWeight.bold,
                                    color: secondarySoft),
                                TxtStyle("More Safety", 16,
                                    fontWeight: FontWeight.bold,
                                    color: secondarySoft),
                                const TxtStyle("\nTotal:", 20,
                                    fontWeight: FontWeight.bold),
                              ]),
                          SizedBox(width: 10.w),
                          Column(children: [
                            TxtStyle("\n${requestModel.extraWeight}\$", 16,
                                color: primary),
                            TxtStyle("${requestModel.extraSize}\$", 16,
                                color: primary),
                            TxtStyle("${requestModel.distanceFees}\$", 16,
                                color: primary),
                            TxtStyle("${requestModel.moreSafety}\$", 16,
                                color: primary),
                            TxtStyle("\n${requestModel.lastPrice}\$", 20),
                          ])
                        ],
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
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
                                .updateRequestStatue(requestModel, "inProgress")
                                .then((value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InProgressScreen(
                                            requestModel: requestModel,
                                            user: value))))
                                .catchError((e) => ShowDialog.show(
                                    context, "Faild", e.toString()));
                          },
                        );
                      }
                    },
                  ),
                  BlocBuilder<RequestCubit, RequestStates>(
                    builder: (context, state) {
                      RequestCubit requestCubit = RequestCubit.get(context);
                      if (state is RequestLoadingState) {
                        return const LoadingWidget();
                      } else {
                        return CustomButton(
                          text: "Delete",
                          width: 180,
                          isDelete: true,
                          onPressed: () {
                            requestCubit
                                .deleteRequest(requestModel, true)
                                .then((value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomeScreen(user: value)),
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
            )
          ])),
    );
  }
}

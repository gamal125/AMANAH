import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/custom_button.dart';
import 'package:amanah/core/utils/widgets/custom_text_field.dart';
import 'package:amanah/core/utils/widgets/dialog.dart';
import 'package:amanah/core/utils/widgets/loading_widget.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:amanah/features/request/application/request_cubit/request_cubit.dart';
import 'package:amanah/features/request/application/request_cubit/request_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../home/data/models/post_model.dart';
import '../../../home/presentation/screens/home_screen.dart';

class RequestScreen extends StatelessWidget {
  final UserModel userModel;
  final PostModel postModel;
  const RequestScreen(
      {required this.userModel, required this.postModel, super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return BlocProvider(
      create: (context) => RequestCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios, color: secondary)),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18, bottom: 20),
          child: BlocConsumer<RequestCubit, RequestStates>(
            listener: (context, state) {
              if (state is AddRequestSuccessState) {
                ShowDialog.show(context, "Request Sent!",
                        "Check You Activities")
                    .then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomeScreen(user: userModel))));
              }
              if (state is RequestErrorState) {
                ShowDialog.show(context, "Fail!", state.message);
              }
            },
            builder: (context, state) {
              RequestCubit requestCubit = RequestCubit.get(context);
              return Form(
                key: requestCubit.requestFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                          child: TxtStyle("Request", 36,
                              fontWeight: FontWeight.bold)),
                      const TxtStyle("\nItem description", 24,
                          fontWeight: FontWeight.bold),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 22.0),
                          child: CustomTextField(
                              placeholder: "Item description",
                              // isDesc: true,
                              controller: requestCubit.descriptionController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Don't let the field empty";
                                } else {
                                  return null;
                                }
                              }),
                        ),
                      ),
                      const TxtStyle("Weight", 24, fontWeight: FontWeight.bold),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 22.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextField(
                                  placeholder: "00",
                                  controller: requestCubit.weightController,
                                  isDate: true,
                                  isNumbers: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Don't let the field empty";
                                    } else {
                                      return null;
                                    }
                                  }),
                              SizedBox(width: 20.w),
                              CustomTextField(
                                  placeholder: "KG",
                                  isDate: true,
                                  readOnly: true,
                                  controller: controller,
                                  validator: (d) {
                                    return null;
                                  }),
                            ]),
                      ),
                      const TxtStyle("Size", 24, fontWeight: FontWeight.bold),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 22.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomTextField(
                                  placeholder: "Height",
                                  isDate: true,
                                  isNumbers: true,
                                  controller: requestCubit.heightController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Don't let the field empty";
                                    } else {
                                      return null;
                                    }
                                  }),
                              CustomTextField(
                                  placeholder: "Width",
                                  isDate: true,
                                  isNumbers: true,
                                  controller: requestCubit.widthController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Don't let the field empty";
                                    } else {
                                      return null;
                                    }
                                  }),
                              CustomTextField(
                                  placeholder: "Depth",
                                  isDate: true,
                                  isNumbers: true,
                                  controller: requestCubit.depthController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Don't let the field empty";
                                    } else {
                                      return null;
                                    }
                                  }),
                            ]),
                      ),
                      const TxtStyle("Item Price", 24,
                          fontWeight: FontWeight.bold),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 22.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextField(
                                  placeholder: "00",
                                  isDate: true,
                                  isNumbers: true,
                                  controller: requestCubit.itemPriceController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Don't let the field empty";
                                    } else {
                                      return null;
                                    }
                                  }),
                              SizedBox(width: 20.w),
                              CustomTextField(
                                  placeholder: "\$",
                                  isDate: true,
                                  readOnly: true,
                                  controller: controller,
                                  validator: (d) {
                                    return null;
                                  }),
                            ]),
                      ),
                      // const Spacer(),
                      Center(
                          child: Conditional.single(
                              context: context,
                              conditionBuilder: (context) =>
                                  requestCubit.state is! RequestLoadingState,
                              fallbackBuilder: (context) => LoadingWidget(),
                              widgetBuilder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, bottom: 20),
                                  child: CustomButton(
                                      text: "Request",
                                      onPressed: () {
                                        if (requestCubit
                                            .requestFormKey.currentState!
                                            .validate()) {
                                          requestCubit.addRequest(
                                              userModel, postModel);
                                        }
                                      }),
                                );
                              }))
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

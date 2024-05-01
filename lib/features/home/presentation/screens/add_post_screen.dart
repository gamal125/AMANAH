import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/custom_button.dart';
import 'package:amanah/core/utils/widgets/custom_text_field.dart';
import 'package:amanah/core/utils/widgets/dialog.dart';
import 'package:amanah/core/utils/widgets/loading_widget.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/auth/data/models/user_model.dart';
import 'package:amanah/features/home/application/post_cubit/post_cubit.dart';
import 'package:amanah/features/home/application/post_cubit/post_states.dart';
import 'package:amanah/features/home/presentation/screens/post_details_screen.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPostScreen extends StatelessWidget {
  final UserModel userModel;
  const AddPostScreen({required this.userModel, super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return BlocProvider.value(
      value: BlocProvider.of<PostCubit>(context),
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios, color: secondary)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BlocConsumer<PostCubit, PostStates>(
              listener: (context, state) {},
              builder: (context, state) {
                PostCubit postCubit = PostCubit.get(context);
                return Form(
                  key: postCubit.postFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                          child: TxtStyle("New Post", 36,
                              fontWeight: FontWeight.bold)),
                      const TxtStyle("\nTravel Destinations", 24,
                          fontWeight: FontWeight.bold),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: CustomTextField(
                              placeholder: "Your current location",
                              controller: postCubit.currentLocationController,
                              onTap: () {
                                showCountryPicker(
                                    context: context,
                                    onSelect: (Country country) {
                                      postCubit.currentLocationController.text =
                                          country.name;
                                    });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Don't let the field empty";
                                } else {
                                  return null;
                                }
                              }),
                        ),
                      ),
                      Center(
                        child: CustomTextField(
                            placeholder: "Where is your next destination",
                            controller: postCubit.destinationController,
                            onTap: () {
                              showCountryPicker(
                                  context: context,
                                  onSelect: (Country country) {
                                    postCubit.destinationController.text =
                                        country.name;
                                  });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Don't let the field empty";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      //date
                      const TxtStyle("\nTravel Date", 24,
                          fontWeight: FontWeight.bold),
                      SizedBox(height: 22.h),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomTextField(
                                placeholder: "Day",
                                controller: postCubit.dayController,
                                isNumbers: true,
                                isDate: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Don't let the field empty";
                                  }  else if(int.parse(value) > 31){
                                     return "Enter valid day";
                                  }else {
                                    return null;
                                  }
                                }),
                            CustomTextField(
                                placeholder: "Month",
                                isNumbers: true,
                                isDate: true,
                                controller: postCubit.monthController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Don't let the field empty";
                                  } else if(int.parse(value) > 12){
                                     return "Enter valid month";
                                  }else {
                                    return null;
                                  }
                                }),
                            CustomTextField(
                                placeholder: "Year",
                                controller: postCubit.yearController,
                                isNumbers: true,
                                isDate: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Don't let the field empty";
                                  } else if(int.parse(value) < 2024){
                                     return "Enter valid year";
                                  }else {
                                    return null;
                                  }
                                }),
                          ]),

                      const TxtStyle("\nTravel Time", 24,
                          fontWeight: FontWeight.bold),
                      SizedBox(height: 22.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomTextField(
                              placeholder: "Hour",
                              isNumbers: true,
                              isDate: true,
                              controller: postCubit.hourController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Don't let the field empty";
                                } else if(int.parse(value) > 24){
                                     return "Enter valid hour";
                                  }else {
                                  return null;
                                }
                              }),
                          CustomTextField(
                              placeholder: "Min",
                              isNumbers: true,
                              isDate: true,
                              controller: postCubit.minutesController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Don't let the field empty";
                                }else if(int.parse(value) > 60){
                                     return "Enter valid minutes";
                                  } else {
                                  return null;
                                }
                              }),
                          CustomTextField(
                              placeholder: postCubit.time,
                              onTap: () => postCubit.changeTime(),
                              readOnly: true,
                              isDate: true,
                              controller: postCubit.timeController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Don't let the field empty";
                                } else {
                                  return null;
                                }
                              }),
                        ],
                      ),
                      const TxtStyle("\nArrival Date", 24,
                          fontWeight: FontWeight.bold),
                      SizedBox(height: 22.h),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomTextField(
                                placeholder: "Day",
                                controller: postCubit.arrdayController,
                                isNumbers: true,
                                isDate: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Don't let the field empty";
                                  } else if(int.parse(value) > 31){
                                     return "Enter valid day";
                                  }else {
                                    return null;
                                  }
                                }),
                            CustomTextField(
                                placeholder: "Month",
                                isNumbers: true,
                                isDate: true,
                                controller: postCubit.arrmonthController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Don't let the field empty";
                                  } else if(int.parse(value) > 12){
                                     return "Enter valid month";
                                  }else {
                                    return null;
                                  }
                                }),
                            CustomTextField(
                                placeholder: "Year",
                                isNumbers: true,
                                isDate: true,
                                controller: postCubit.arryearController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Don't let the field empty";
                                  }else if(int.parse(value) < 2024){
                                     return "Enter valid year";
                                  } else {
                                    return null;
                                  }
                                }),
                          ]),
                      const TxtStyle("\nArrival Time", 24,
                          fontWeight: FontWeight.bold),
                      SizedBox(height: 22.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomTextField(
                              placeholder: "Hour",
                              isNumbers: true,
                              isDate: true,
                              controller: postCubit.arrhourController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Don't let the field empty";
                                }else if(int.parse(value) > 24){
                                     return "Enter valid day";
                                  } else {
                                  return null;
                                }
                              }),
                          CustomTextField(
                              placeholder: "Min",
                              isNumbers: true,
                              isDate: true,
                              controller: postCubit.arrminutesController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Don't let the field empty";
                                } else if(int.parse(value) > 60){
                                     return "Enter valid minutes";
                                  }else {
                                  return null;
                                }
                              }),
                          CustomTextField(
                              placeholder: postCubit.time,
                              onTap: () => postCubit.changeTime(arrival: true),
                              readOnly: true,
                              isDate: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Don't let the field empty";
                                } else {
                                  return null;
                                }
                              },
                              controller: postCubit.arrtimeController),
                        ],
                      ),
                      const TxtStyle("\nWeight", 24,
                          fontWeight: FontWeight.bold),
                      SizedBox(height: 22.h),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextField(
                                placeholder: "00",
                                isDate: true,
                                isNumbers: true,
                                controller: postCubit.weightController,
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
                                readOnly: true,
                                isDate: true,
                                controller: controller),
                          ]),
                      const TxtStyle("\nSize", 24, fontWeight: FontWeight.bold),
                      SizedBox(height: 22.h),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomTextField(
                                placeholder: "Height",
                                isDate: true,
                                isNumbers: true,
                                controller: postCubit.heightController,
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
                                controller: postCubit.widthController,
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
                                controller: postCubit.depthController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Don't let the field empty";
                                  } else {
                                    return null;
                                  }
                                }),
                          ]),
                      const TxtStyle("\nRecommended Items", 24,
                          fontWeight: FontWeight.bold),
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: SizedBox(
                                height: 55.h,
                                width: 318.w,
                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(6),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: primary),
                                            borderRadius:
                                                BorderRadius.circular(15.r)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: primary),
                                            borderRadius:
                                                BorderRadius.circular(15.r))),
                                    items: postCubit.collections
                                        .map((collection) => DropdownMenuItem(
                                            value: collection,
                                            child: TxtStyle(collection, 12)))
                                        .toList(),
                                    value: postCubit.selectedCollection,
                                    onChanged: (collection) => postCubit.setCollection(collection!)))

                            ),
                      ),
                      Center(
                        child: CustomTextField(
                            placeholder: "Other",
                            controller: postCubit.othersController),
                      ),
                      const TxtStyle("\nBase Price", 24,
                          fontWeight: FontWeight.bold),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextField(
                                  placeholder: "00",
                                  isNumbers: true,
                                  isDate: true,
                                  controller: postCubit.basePriceController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Don't let the field empty";
                                    } else {
                                      return null;
                                    }
                                  }),
                              SizedBox(width: 20.w),
                              CustomTextField(
                                  readOnly: true,
                                  isDate: true,
                                  placeholder: "\$",
                                  controller: controller),
                            ]),
                      ),
                      Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! PostLoadingState,
                          fallbackBuilder: (context) => const LoadingWidget(),
                          widgetBuilder: (context) {
                            return Center(
                                child: CustomButton(
                                    text: "Post",
                                    onPressed: () {
                                      if (postCubit.postFormKey.currentState!
                                          .validate()) {
                                        postCubit
                                            .addPost()
                                            .then((post) => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PostDetailsScreen(
                                                            postModel: post,
                                                            userModel:
                                                                userModel))))
                                            .catchError((_) => ShowDialog.show(
                                                context,
                                                "Error Adding Post",
                                                _.toString()));
                                      }
                                    }));
                          }),
                      SizedBox(height: 22.h),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

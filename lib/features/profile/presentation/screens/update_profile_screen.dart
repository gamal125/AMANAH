import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/custom_button.dart';
import 'package:amanah/core/utils/widgets/custom_text_field.dart';
import 'package:amanah/core/utils/widgets/dialog.dart';
import 'package:amanah/core/utils/widgets/loading_widget.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/profile/application/profile_cubit/profile_cubit.dart';
import 'package:amanah/features/profile/application/profile_cubit/profile_states.dart';
import 'package:amanah/features/profile/presentation/screens/change_profile_photo.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../../../auth/data/models/user_model.dart';

class UpdateProfileScreen extends StatelessWidget {
  final UserModel userModel;
  const UpdateProfileScreen({required this.userModel, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios, color: secondary)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 56),
            child: BlocConsumer<ProfileCubit, ProfileStates>(
              listener: (context, state) {
                if (state is ProfileErrorState) {
                  ShowDialog.show(context, "Sorry", state.message);
                }
              },
              builder: (context, state) {
                ProfileCubit profileCubit = ProfileCubit.get(context);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 80),
                      child: TxtStyle("Update Profile", 36,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                              placeholder: userModel.firstName,
                              controller: profileCubit.firstNameController,
                              validator: (value) {
                                return null;
                              }),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomTextField(
                              placeholder: userModel.lastName,
                              controller: profileCubit.lastNameController,
                              validator: (value) {
                                return null;
                              }),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 27),
                      child: CustomTextField(
                          onTap: () async {
                            final DateTime today = DateTime.now();
                
                            DateTime? birthday = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1800),
                                lastDate: DateTime(2100));
                            if (birthday != null) {
                              profileCubit.birthdayController.text =
                                  "${birthday.day}-${birthday.month}-${birthday.year}";
                            } else {
                              profileCubit.birthdayController.text =
                                  "${today.day}-${today.month}-${today.year}";
                            }
                          },
                          readOnly: true,
                          placeholder: userModel.dateOfBirth,
                          controller: profileCubit.birthdayController,
                          validator: (value) {
                            return null;
                          }),
                    ),
                    CustomTextField(
                        placeholder: userModel.phoneNumber,
                        controller: profileCubit.phoneController,
                        isNumbers: true,
                        validator: (value) {
                          return null;
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 27),
                      child: CustomTextField(
                          onTap: () {
                            showCountryPicker(
                                context: context,
                                onSelect: (Country country) {
                                  profileCubit.countryController.text =
                                      country.name;
                                });
                          },
                          readOnly: true,
                          placeholder: userModel.country,
                          controller: profileCubit.countryController,
                          validator: (value) {
                            return null;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Conditional.single(
                          context: context,
                          conditionBuilder: (BuildContext context) =>
                              state is! ProfileLoadingState,
                          fallbackBuilder: (BuildContext context) =>
                              const LoadingWidget(),
                          widgetBuilder: (context) {
                            return CustomButton(
                                text: "Continue",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BlocProvider.value(
                                                  value: profileCubit,
                                                  child:
                                                      ChangeProfilePhotoScreen(
                                                          profileCubit:
                                                              profileCubit,
                                                          user: userModel))));
                                });
                          }),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

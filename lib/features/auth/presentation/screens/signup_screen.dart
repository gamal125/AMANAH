import 'package:amanah/core/utils/colors/colors.dart';
import 'package:amanah/core/utils/widgets/custom_button.dart';
import 'package:amanah/core/utils/widgets/custom_text_field.dart';
import 'package:amanah/core/utils/widgets/dialog.dart';
import 'package:amanah/core/utils/widgets/loading_widget.dart';
import 'package:amanah/core/utils/widgets/txt_style.dart';
import 'package:amanah/features/auth/application/signup_cubit/signup_cubit.dart';
import 'package:amanah/features/auth/application/signup_cubit/signup_states.dart';
import 'package:amanah/features/auth/presentation/screens/scan_passport_screen.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
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
            child: BlocConsumer<SignupCubit, SignupStates>(
              listener: (context, state) {
                SignupCubit signupCubit = SignupCubit.get(context);
                if (state is SignupErrorState) {
                  ShowDialog.show(context, "Sorry", state.message);
                }
                if (state is EmailVerifiedState) {
                  ShowDialog.show(
                          context, "Verify Your Email", "Check Your Inbox")
                      .then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                  value: signupCubit,
                                  child: ScanPassportScreen(
                                      signupCubit: signupCubit)))));
                }
              },
              builder: (context, state) {
                SignupCubit signupCubit = SignupCubit.get(context);

                return Form(
                  key: signupCubit.signupFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 80),
                        child: TxtStyle("Sign Up", 36,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                                placeholder: "First Name",
                                controller: signupCubit.firstNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Don't let the field empty";
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                                placeholder: "Last Name",
                                controller: signupCubit.lastNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Don't let the field empty";
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: CustomTextField(
                            onTap: () async {
                              final DateTime today = DateTime.now();

                              DateTime? birthday = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1800),
                                  lastDate: DateTime(2100));
                              if (birthday != null) {
                                signupCubit.birthdayController.text =
                                    "${birthday.day}-${birthday.month}-${birthday.year}";
                              } else {
                                signupCubit.birthdayController.text =
                                    "${today.day}-${today.month}-${today.year}";
                              }
                            },
                            readOnly: true,
                            placeholder: "Date of Birth",
                            controller: signupCubit.birthdayController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Don't let the field empty";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      CustomTextField(
                          placeholder: "Phone Number",
                          controller: signupCubit.phoneController,
                          isNumbers: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Don't let the field empty";
                            } else {
                              return null;
                            }
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: CustomTextField(
                            placeholder: "Email",
                            controller: signupCubit.emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Don't let the field empty";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      CustomTextField(
                          placeholder: "Password",
                          controller: signupCubit.passController,
                          isPassword: signupCubit.isPassword,
                          isPassField: true,
                          suffixIcon: signupCubit.suffixIcon,
                          suffixOnTap: () => signupCubit.changePassVisibilty(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Don't let the field empty";
                            } else {
                              return null;
                            }
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: CustomTextField(
                            placeholder: "Confirm Password",
                            controller: signupCubit.confirmPassController,
                            isPassword: signupCubit.isPassword,
                            isPassField: true,
                            suffixIcon: signupCubit.suffixIcon,
                            suffixOnTap: () =>
                                signupCubit.changePassVisibilty(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Confirm Your Password";
                              } else if (value !=
                                  signupCubit.passController.text) {
                                return "Passwords doesn't match!";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      CustomTextField(
                          onTap: () {
                            showCountryPicker(
                                context: context,
                                onSelect: (Country country) {
                                  signupCubit.countryController.text =
                                      country.name;
                                });
                          },
                          readOnly: true,
                          placeholder: "Country",
                          controller: signupCubit.countryController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Don't let the field empty";
                            } else {
                              return null;
                            }
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Conditional.single(
                            context: context,
                            conditionBuilder: (BuildContext context) =>
                                state is! SignupLoadingState,
                            fallbackBuilder: (BuildContext context) =>
                                const LoadingWidget(),
                            widgetBuilder: (context) {
                              return CustomButton(
                                  text: "Sign Up",
                                  onPressed: () {
                                    if (signupCubit.signupFormKey.currentState!
                                        .validate()) {
                                      signupCubit
                                          .signuprUser()
                                          .then((value) async {})
                                          .catchError((c) {
                                        ShowDialog.show(
                                            context, "Sorry", c.toString());
                                        return null;
                                      });
                                    }
                                  });
                            }),
                      ),
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

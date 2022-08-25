import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/odc_web/modules/register/cubit/cubit.dart';
import 'package:odc/odc_web/modules/register/cubit/states.dart';
import 'package:odc/shared/components/components.dart';
import 'package:odc/shared/components/constants.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {}
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "First Name",
                                style: TextStyle(color: greyColor),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              defaultFormField(
                                controller: firstNameController,
                                type: TextInputType.name,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter your first name';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Last Name",
                                style: TextStyle(color: greyColor),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              defaultFormField(
                                controller: lastNameController,
                                type: TextInputType.name,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter your last name';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(color: greyColor),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(color: greyColor),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    defaultFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      suffix: cubit.suffix,
                      onSubmit: (value) {},
                      isPassword: cubit.isPassword,
                      suffixPressed: () {
                        cubit.changePasswordVisibility();
                      },
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'password is too short';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      "Confirm Password",
                      style: TextStyle(color: greyColor),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    defaultFormField(
                      controller: confirmPasswordController,
                      type: TextInputType.visiblePassword,
                      suffix: cubit.suffix,
                      onSubmit: (value) {},
                      isPassword: cubit.isPassword,
                      suffixPressed: () {
                        cubit.changePasswordVisibility();
                      },
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'password is too short';
                        } else if (passwordController.text !=
                            confirmPasswordController.text) {
                          return 'password is not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    ConditionalBuilder(
                      condition: state is! RegisterLoadingState,
                      builder: (context) => defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.userRegister(
                              firsName: firstNameController.text,
                              lastName: lastNameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        text: 'register',
                        isUpperCase: true,
                      ),
                      fallback: (context) => const Center(
                          child: CircularProgressIndicator(
                        color: buttonColor,
                      )),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.2,
                          child: const Divider(
                            color: Colors.grey,
                          ),
                        ),
                        const Text(
                          " or continue with ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: size.width * 0.2,
                          child: const Divider(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Image.asset("assets/icons/google.png"),
                        ),
                        SizedBox(
                          width: size.width * 0.1,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Image.asset("assets/icons/facebook.png"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

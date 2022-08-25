import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/odc_web/modules/account/cubit/cubit.dart';
import 'package:odc/odc_web/modules/account/cubit/states.dart';
import 'package:odc/shared/components/components.dart';
import 'package:odc/shared/components/constants.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AccountCubit, AccountStates>(
      listener: (context, state) {
        if (state is SuccessChangeNameState) {
          AccountCubit.get(context).getData();
        } else if (state is SuccessChangeEmailState) {
          AccountCubit.get(context).getData();
        }
      },
      builder: (context, state) {
        AccountCubit cubit = AccountCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.userModel != null,
            builder: (context) {
              firstNameController.text = cubit.userModel!.data!.firstName!;
              lastNameController.text = cubit.userModel!.data!.lastName!;
              emailController.text = cubit.userModel!.data!.email!;
              addressController.text = cubit.userModel!.data!.address!;
              return Center(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "My Profile",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: Row(
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
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(color: greyColor),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              defaultFormField(
                                controller: emailController,
                                type: TextInputType.name,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter your email';
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
                                "Address",
                                style: TextStyle(color: greyColor),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              defaultFormField(
                                controller: addressController,
                                type: TextInputType.name,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter your address';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                      width: size.width * 0.1,
                      height: size.width * 0.03,
                      child: defaultButton(function: () {
                        cubit.changeProfile(
                          context: context,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          email: emailController.text,
                          address: addressController.text,
                        );
                      }, text: "Save")),
                ],
              ));
            },
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: buttonColor,
                  ),
                ));
      },
    );
  }
}

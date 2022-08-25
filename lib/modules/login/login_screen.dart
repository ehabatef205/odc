import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/layout/layout/layout.dart';
import 'package:odc/modules/login/cubit/cubit.dart';
import 'package:odc/modules/login/cubit/states.dart';
import 'package:odc/shared/components/components.dart';
import 'package:odc/shared/components/constants.dart';
import 'package:odc/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel!.type == "Success") {
              print(state.loginModel!.message);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel!.data!.accessToken,
              ).then((value) {
                token = state.loginModel!.data!.accessToken;

                navigateAndFinish(
                  context,
                  Layout(),
                );
              });
            } else {
              print(state.loginModel!.message);
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                    type: TextInputType.emailAddress,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.04,
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
                    height: size.height * 0.04,
                  ),
                  ConditionalBuilder(
                    condition: state is! LoginLoadingState,
                    builder: (context) => defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          cubit.userLogin(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                      },
                      text: 'login',
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
                        width: size.width * 0.29,
                        child: const Divider(
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        " or continue with ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        width: size.width * 0.29,
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

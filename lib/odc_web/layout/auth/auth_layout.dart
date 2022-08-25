import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/odc_web/layout/auth/cubit/cubit.dart';
import 'package:odc/odc_web/layout/auth/cubit/states.dart';
import 'package:odc/shared/components/components.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/logo.png",
                                width: size.width * 0.05,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              textButton2(cubit, 0, "Home"),
                              SizedBox(width: size.width * 0.05,),
                              textButton2(cubit, 1, "Shop"),
                              SizedBox(width: size.width * 0.05,),
                              textButton2(cubit, 2, "Blog"),
                              SizedBox(width: size.width * 0.05,),
                              textButton2(cubit, 3, "About"),
                              SizedBox(width: size.width * 0.05,),
                              textButton2(cubit, 4, "Community"),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              width: size.width * 0.08,
                              height: size.height * 0.05,
                              child: defaultButton(
                                  function: () {}, text: "Sign Up"),
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    cubit.changeScreenNavigator(0);
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        "Signup",
                                        style: TextStyle(
                                            color: cubit.currentIndex == 0
                                                ? Colors.green
                                                : Colors.grey,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Container(
                                        width: 25,
                                        height: 3,
                                        color: cubit.currentIndex == 0
                                            ? Colors.green
                                            : Colors.transparent,
                                      )
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    cubit.changeScreenNavigator(1);
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        "Login",
                                        style: TextStyle(
                                            color: cubit.currentIndex == 1
                                                ? Colors.green
                                                : Colors.grey,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Container(
                                        width: 25,
                                        height: 3,
                                        color: cubit.currentIndex == 1
                                            ? Colors.green
                                            : Colors.transparent,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: cubit.screens[cubit.currentIndex])
                        ],
                      ))
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Image.asset("assets/image2.png"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget textButton2(AuthCubit cubit, int index, String text) {
    return TextButton(
      onPressed: () {
        cubit.changeLis(index);
      },
      child: Text(
        text,
        style: TextStyle(
            color: cubit.currentIndex2 == index ? Colors.green : Colors.black,
            fontSize: 18),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/layout/auth/cubit/cubit.dart';
import 'package:odc/layout/auth/cubit/states.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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
                  Container(
                    alignment: Alignment.topRight,
                    child: Image.asset("assets/image.png"),
                  ),
                  Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/logo.png", height: size.height * 0.05,),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Row(
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
                                        fontSize: size.width * 0.06),
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
                                        fontSize: size.width * 0.06),
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
                        cubit.screens[cubit.currentIndex],
                      ],
                    ),
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
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/layout/auth/auth_layout.dart';
import 'package:odc/layout/layout/layout.dart';
import 'package:odc/modules/splash/cubit/cubit.dart';
import 'package:odc/modules/splash/cubit/states.dart';
import 'package:odc/shared/components/components.dart';
import 'package:odc/shared/components/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => SplashCubit(),
      child: BlocConsumer<SplashCubit, SplashStates>(
        listener: (context, state) {
          if (state is StartAppState) {}
        },
        builder: (context, state) {
          var cubit = SplashCubit.get(context);
          if (!cubit.start) {
            cubit.changeStart();
          }
          cubit.startApp(context);
          return Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                    duration: const Duration(seconds: 3),
                    right: cubit.start ? width * 0.25 : -width * 0.5,
                    curve: Curves.fastOutSlowIn,
                    child: Container(
                        width: width * 0.5,
                        margin: EdgeInsets.only(bottom: width * 0.15),
                        child: const Image(
                          image: AssetImage("assets/logo.png"),
                        ))),
              ],
            ),
          );
        },
      ),
    );
  }
}

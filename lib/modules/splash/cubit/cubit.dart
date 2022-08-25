import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/layout/auth/auth_layout.dart';
import 'package:odc/layout/layout/layout.dart';
import 'package:odc/modules/splash/cubit/states.dart';
import 'package:odc/shared/components/components.dart';
import 'package:odc/shared/components/constants.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(SplashInitialState());

  static SplashCubit get(context) => BlocProvider.of(context);

  bool start = false;

  void changeStart() {
    Timer(const Duration(seconds: 1), () {
      start = true;
    });

    emit(SplashChangeState());
  }

  void startApp(context) {
    Timer(Duration(seconds: 5), (){
      if (token == null) {
        navigateTo(context, const AuthLayout());
      } else {
      navigateTo(context, const Layout());
      }
    });
  }
}

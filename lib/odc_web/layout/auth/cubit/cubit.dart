import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/odc_web/layout/auth/cubit/states.dart';
import 'package:odc/odc_web/modules/login/login_screen.dart';
import 'package:odc/odc_web/modules/register/register_screen.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialStates());

  static AuthCubit get(context) => BlocProvider.of(context);

  int currentIndex = 1;

  int currentIndex2 = 0;

  List<Widget> screens = [
    RegisterScreen(),
    LoginScreen(),
  ];

  void changeLis(int index) {
    currentIndex2 = index;
    emit(AuthListStates());
  }

  void changeScreenNavigator(int index) {
    currentIndex = index;
    emit(AuthScreenStates());
  }
}

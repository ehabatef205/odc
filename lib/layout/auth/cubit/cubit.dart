import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/layout/auth/cubit/states.dart';
import 'package:odc/modules/login/login_screen.dart';
import 'package:odc/modules/register/register_screen.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialStates());

  static AuthCubit get(context) => BlocProvider.of(context);

  int currentIndex = 1;

  List<Widget> screens = [
    RegisterScreen(),
    LoginScreen(),
  ];

  void changeScreenNavigator(int index) {
    currentIndex = index;
    emit(AuthScreenStates());
  }
}

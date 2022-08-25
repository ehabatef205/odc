import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/models/login_model.dart';
import 'package:odc/modules/login/cubit/states.dart';
import 'package:odc/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());

   try{
      DioHelper.postData(
        url: "/api/v1/auth/signin",
        data: {
          'email': email,
          'password': password,
        },
      ).then((value) {
        print(value.data);
        loginModel = LoginModel.fromJson(value.data);
        emit(LoginSuccessState(loginModel));
      }).catchError((error) {
        print(error.toString());
        emit(LoginErrorState(error.toString()));
      });
    }catch(e){}
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityState());
  }
}

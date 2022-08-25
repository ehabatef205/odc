import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/modules/register/cubit/states.dart';
import 'package:odc/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String firsName,
    required String lastName,
    required String email,
    required String password,
  })
  {
    emit(RegisterLoadingState());

    DioHelper.postData(
      url: "/api/v1/auth/signup",
      data:
      {
        'firstName': firsName,
        'lastName': lastName,
        'email': email,
        'password': password,
      },
    ).then((value)
    {
      emit(RegisterSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(RegisterChangePasswordVisibilityState());
  }
}


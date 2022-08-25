import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/odc_web/layout/layout/cubit/states.dart';
import 'package:odc/models/user_model.dart';
import 'package:odc/odc_web/modules/account/account_screen.dart';
import 'package:odc/odc_web/modules/blog/blog_screen.dart';
import 'package:odc/odc_web/modules/forums_all/forums_all_screen.dart';
import 'package:odc/odc_web/modules/home/home_screen.dart';
import 'package:odc/odc_web/modules/notification/notification_Screen.dart';
import 'package:odc/odc_web/modules/scan/scan_screen.dart';
import 'package:odc/shared/components/constants.dart';
import 'package:odc/shared/network/remote/dio_helper.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialStates());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  UserModel? userModel;

  List<Widget> screen = [
    HomeScreen(),
    Container(),
    BlogScreen(),
    Container(),
    ForumsAllScreen(),
    AccountScreen(),
  ];

  void changeScreen(int index) {
    currentIndex = index;
    emit(LayoutChangeBottomNavigatorStates());
  }

  void getData() {
    emit(LayoutLoadingStates());

    DioHelper.getData(url: "/api/v1/user/me", token: token).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(LayoutSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(LayoutErrorStates());
    });
  }
}

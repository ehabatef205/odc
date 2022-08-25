import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/layout/layout/cubit/states.dart';
import 'package:odc/modules/account/account_screen.dart';
import 'package:odc/modules/forums_all/forums_all_screen.dart';
import 'package:odc/modules/home/home_screen.dart';
import 'package:odc/modules/notification/notification_Screen.dart';
import 'package:odc/modules/scan/scan_screen.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialStates());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 2;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.add),
      label: "",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.qr_code_scanner_outlined),
      label: "",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: "",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.notifications_active_outlined),
      label: "",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline_sharp),
      label: "",
    ),
  ];

  List<Widget> screens = [
    ForumsAllScreen(),
    ScanScreen(),
    HomeScreen(),
    NotificationScreen(),
    AccountScreen(),
  ];

  List<Widget> aapBar(Size size) {
    List<Widget> appBar = [
      const Text("Discussion Forums"),
      const Text("Scan Screen"),
      Image.asset(
        "assets/logo.png",
        height: size.height * 0.05,
      ),
      const Text("Notification Screen"),
      const Text("Account Screen"),
    ];

    return appBar;
  }

  void changeBottomNavigator(int index) {
    currentIndex = index;
    emit(LayoutChangeBottomNavigatorStates());
  }
}

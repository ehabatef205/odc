import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/odc_web/layout/layout/layout.dart';
import 'package:odc/modules/account/cubit/cubit.dart';
import 'package:odc/modules/forums_all/cubit/cubit.dart';
import 'package:odc/modules/home/cubit/cubit.dart';
import 'package:odc/modules/splash/splash_screen.dart';
import 'package:odc/shared/bloc_observer.dart';
import 'package:odc/shared/components/constants.dart';
import 'package:odc/shared/network/local/cache_helper.dart';
import 'package:odc/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  token = CacheHelper.getData(key: 'token');
  printFullText(text: token ?? '');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ForumsAllCubit()..getForumsMe(),
        ),
        BlocProvider(
          create: (BuildContext context) => AccountCubit()..getData(),
        ),
        BlocProvider(
          create: (BuildContext context) => HomeCubit()
            ..getProducts()
            ..getPlants()
            ..getSeeds()
            ..getTools()
            ..getNamesForSearch(),
        ),
      ],
      child: MaterialApp(
        title: 'ODC',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: Platform.isAndroid? SplashScreen() : Layout(),
      ),
    );
  }
}

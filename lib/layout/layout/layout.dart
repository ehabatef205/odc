import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/layout/layout/cubit/cubit.dart';
import 'package:odc/layout/layout/cubit/states.dart';

class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          return Scaffold(
            appBar: cubit.currentIndex == 1 || cubit.currentIndex == 4? null: AppBar(
              title: cubit.aapBar(size)[cubit.currentIndex],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.green,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavigator(index);
              },
              items: cubit.bottomItems,
            ),
          );
        },
      ),
    );
  }
}

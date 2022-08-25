import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/odc_web/layout/layout/cubit/cubit.dart';
import 'package:odc/odc_web/layout/layout/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:odc/odc_web/modules/account/account_screen.dart';
import 'package:odc/odc_web/modules/blog/blog_screen.dart';
import 'package:odc/odc_web/modules/forums_all/forums_all_screen.dart';
import 'package:odc/shared/components/components.dart';
import 'package:odc/shared/components/constants.dart';

class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => LayoutCubit()..getData(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          return ConditionalBuilder(
              condition: cubit.userModel != null,
              builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: size.width * 0.05),
                            child: Image(
                              image: const AssetImage("assets/logo.png"),
                              width: size.width * 0.05,
                            ),
                          ),
                          textButton2(cubit, 0, "Home"),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          textButton2(cubit, 1, "Shop"),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          textButton2(cubit, 2, "Blog"),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          textButton2(cubit, 3, "About"),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          textButton2(cubit, 4, "Community"),
                          Padding(
                              padding: EdgeInsets.only(left: size.width * 0.05),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.notifications_active_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.changeScreen(5);
                                    },
                                    child: CircleAvatar(
                                      child: Image(
                                        image: NetworkImage(
                                            cubit.userModel!.data!.imageUrl!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          cubit.screen[cubit.currentIndex],
                        ],
                      ),
                    ),
                  ),
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(
                      color: buttonColor,
                    ),
                  ));
        },
      ),
    );
  }

  Widget textButton2(LayoutCubit cubit, int index, String text) {
    return TextButton(
      onPressed: () {
        cubit.changeScreen(index);
      },
      child: Text(
        text,
        style: TextStyle(
            color: cubit.currentIndex == index ? Colors.green : Colors.black,
            fontSize: 18),
      ),
    );
  }
}

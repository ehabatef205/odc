import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/layout/auth/auth_layout.dart';
import 'package:odc/models/seed_model.dart';
import 'package:odc/modules/home/cubit/cubit.dart';
import 'package:odc/modules/home/cubit/states.dart';
import 'package:odc/modules/search/search_screen.dart';
import 'package:odc/shared/components/components.dart';
import 'package:odc/shared/components/constants.dart';
import 'package:odc/shared/network/local/cache_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is SuccessHomeStates) {
          HomeCubit.get(context).changeHome(0);
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.model != null,
            builder: (context) => seedBuilder(context, cubit.model, cubit),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: buttonColor,
                  ),
                ));
      },
    );
  }

  Widget seedBuilder(context, model, HomeCubit cubit) => Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            InkWell(
              onTap: () async{
                var result = await showSearch<String>(
                  context: context,
                  delegate: CustomDelegate(),
                );
              },
              child: defaultFormFieldSearch(),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 35,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  inkWell("All", () {
                    cubit.changeHome(0);
                  }, cubit, 0),
                  const SizedBox(
                    width: 10,
                  ),
                  inkWell("Plants", () {
                    cubit.changeHome(1);
                  }, cubit, 1),
                  const SizedBox(
                    width: 10,
                  ),
                  inkWell("Seeds", () {
                    cubit.changeHome(2);
                  }, cubit, 2),
                  const SizedBox(
                    width: 10,
                  ),
                  inkWell("Tools", () {
                    cubit.changeHome(3);
                  }, cubit, 3),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1 / 1.8,
              children: List.generate(
                model!.data!.length,
                (index) => buildCart(
                  model,
                  index,
                  cubit.currentIndex,
                ),
              ),
            )),
          ],
        ),
      );

  InkWell inkWell(String text, onTap, HomeCubit cubit, int index) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.shade100,
            border: Border.all(
              color: cubit.currentIndex == index
                  ? buttonColor
                  : Colors.transparent,
              width: 2,
            )),
        width: 100,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: cubit.currentIndex == index ? buttonColor : Colors.grey,
                fontSize: 18,
                fontWeight: cubit.currentIndex == index
                    ? FontWeight.bold
                    : FontWeight.w400),
          ),
        ),
      ),
    );
  }

  Widget buildCart(model, int index, int currentIndex) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              model.data![index].imageUrl == ""
                  ? const Image(
                      image: AssetImage(
                        "assets/background.png",
                      ),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                    )
                  : Image(
                      image: NetworkImage(
                        "https://lavie.orangedigitalcenteregypt.com${model.data![index].imageUrl}",
                      ),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
              Text(
                model.data![index].name!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                currentIndex == 0
                    ? "${model.data![index].price!} EGP"
                    : model.data![index].description!,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  height: 35,
                  child: defaultButton(
                    function: () {},
                    text: "Add To Cart",
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

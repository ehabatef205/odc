import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/models/product_id_model.dart';
import 'package:odc/odc_web/modules/blog/blog_screen.dart';
import 'package:odc/odc_web/modules/show_details/cubit/cubit.dart';
import 'package:odc/odc_web/modules/show_details/cubit/states.dart';
import 'package:odc/shared/components/components.dart';

class ShowDetailsScreen extends StatelessWidget {
  final ProductIdModel productIdModel;

  const ShowDetailsScreen({required this.productIdModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ShowDetailsCubit(),
      child: BlocConsumer<ShowDetailsCubit, ShowDetailsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Container(
                        height: size.height * 0.5,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://lavie.orangedigitalcenteregypt.com${productIdModel.data!.imageUrl}"))),
                        child: Container(
                          height: size.height * 0.6,
                          decoration:
                              const BoxDecoration(color: Colors.black45),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black87),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Icon(
                                          Icons.light_mode_outlined,
                                          color: Colors.grey,
                                          size: size.height * 0.04,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productIdModel.data!.plant!.sunLight!
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      const Text(
                                        "Sun light",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black87),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Icon(
                                          Icons.water_drop_outlined,
                                          color: Colors.grey,
                                          size: size.height * 0.04,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productIdModel
                                            .data!.plant!.waterCapacity!
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      const Text(
                                        "Water Capacity",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black87),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Icon(
                                          Icons.ac_unit_rounded,
                                          color: Colors.grey,
                                          size: size.height * 0.04,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productIdModel.data!.plant!.temperature!
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      const Text(
                                        "Temperature",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.4,
                      ),
                    ],
                  ),
                  Container(
                    height: size.height * 0.55,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                Text(
                                  productIdModel.data!.plant!.name!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  productIdModel.data!.plant!.description!,
                                  style: const TextStyle(),
                                )
                              ],
                            ),
                          ),
                          defaultButton(
                              function: () {
                                navigateTo(context, BlogScreen());
                              },
                              text: "Go to Blog")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

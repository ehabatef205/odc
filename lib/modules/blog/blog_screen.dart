import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/modules/blog/cubit/cubit.dart';
import 'package:odc/modules/blog/cubit/states.dart';
import 'package:odc/modules/show_blog/show_blog_screen.dart';
import 'package:odc/shared/components/components.dart';
import 'package:odc/shared/components/constants.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlogCubit()..getBlog(),
      child: BlocConsumer<BlogCubit, BlogStates>(
        listener: (context, state) {},
        builder: (context, state) {
          BlogCubit cubit = BlogCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Blogs"),
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: ConditionalBuilder(
              condition: cubit.blogModel != null,
              builder: (context) => card(context, cubit),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(
                  color: buttonColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget card(BuildContext context, BlogCubit cubit) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: cubit.blogModel!.data!.plants!.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  navigateTo(
                      context,
                      ShowBloScreen(
                        blogModel: cubit.blogModel!,
                        index: index,
                      ));
                },
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        cubit.blogModel!.data!.plants![index].imageUrl != ""
                            ? Container(
                                height: size.width * 0.2,
                                width: size.width * 0.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "https://lavie.orangedigitalcenteregypt.com${cubit.blogModel!.data!.plants![index].imageUrl}",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                height: size.width * 0.2,
                                width: size.width * 0.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/background.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.blogModel!.data!.plants![index].name!,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                cubit.blogModel!.data!.plants![index]
                                    .description!,
                                maxLines: 2,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}

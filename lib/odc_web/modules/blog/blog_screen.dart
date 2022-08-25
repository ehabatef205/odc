import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/models/blog_model.dart';
import 'package:odc/odc_web/modules/blog/cubit/cubit.dart';
import 'package:odc/odc_web/modules/blog/cubit/states.dart';
import 'package:odc/odc_web/modules/show_blog/show_blog_screen.dart';
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
          return ConditionalBuilder(
            condition: cubit.blogModel != null,
            builder: (context) => buildBlog(context, cubit),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(
                color: buttonColor,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildBlog(context, BlogCubit cubit) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: size.height,
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1 / 0.52,
                children: List.generate(
                  cubit.blogModel!.data!.plants!.length,
                  (index) => buildCart(
                    context,
                    cubit.blogModel!,
                    index,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCart(context, BlogModel model, int index) {
    return InkWell(
      onTap: (){
        navigateTo(context, ShowBloScreen(
          blogModel: model,
          index: index,
        ));
      },
      child: Card(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                model.data!.plants![index].imageUrl == ""
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
                          "https://lavie.orangedigitalcenteregypt.com${model.data!.plants![index].imageUrl}",
                        ),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                Text(
                  model.data!.plants![index].name!,
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
                  model.data!.plants![index].description!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

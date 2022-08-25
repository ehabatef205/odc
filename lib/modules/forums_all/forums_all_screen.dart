import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/modules/forums_all/cubit/cubit.dart';
import 'package:odc/modules/forums_all/cubit/states.dart';
import 'package:odc/modules/post/post_screen.dart';
import 'package:odc/shared/components/components.dart';
import 'package:odc/shared/components/constants.dart';

class ForumsAllScreen extends StatelessWidget {
  const ForumsAllScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ForumsAllCubit()
        ..changeScreen(0),
      child: BlocConsumer<ForumsAllCubit, ForumsAllStates>(
          listener: (context, state) {},
          builder: (context, state) {
            ForumsAllCubit cubit = ForumsAllCubit.get(context);
            return Stack(
              alignment: Alignment.bottomRight,
              children: [
                ConditionalBuilder(
                    condition: cubit.forumModel != null,
                    builder: (context) => listView(context, cubit),
                    fallback: (context) => const Center(
                          child: CircularProgressIndicator(
                            color: buttonColor,
                          ),
                        )),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: FloatingActionButton(
                    onPressed: () {
                      navigateTo(context, PostScreen());
                    },
                    backgroundColor: buttonColor,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget listView(context, ForumsAllCubit cubit) {
    return Column(
      children: [
        SizedBox(
          height: 55,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              inkWell("All Forums", () {
                cubit.changeScreen(0);
              }, cubit, 0),
              const SizedBox(
                width: 10,
              ),
              inkWell("My Forums", () {
                cubit.changeScreen(1);
              }, cubit, 1),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cubit.forumModel!.data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  image: NetworkImage(cubit.forumModel!
                                      .data![index].user!.imageUrl!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: Text(
                                  "${cubit.forumModel!.data![index].user!.firstName} ${cubit.forumModel!.data![index].user!.lastName}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          cubit.forumModel!.data![index].title!,
                          style: const TextStyle(
                            color: buttonColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                          right: 10,
                          left: 10,
                        ),
                        child: Text(
                          cubit.forumModel!.data![index].description!,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      cubit.forumModel!.data![index].imageUrl != null
                          ? Image(
                              image: NetworkImage(
                                "https://lavie.orangedigitalcenteregypt.com${cubit.forumModel!.data![index].imageUrl}",
                              ),
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            )
                          : const Image(
                              image: AssetImage(
                                "assets/rectangle.png",
                              ),
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                cubit.postLike(
                                    forumId: cubit
                                        .forumModel!.data![index].forumId!);
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.favorite_border,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    " ${cubit.forumModel!.data![index].forumLikes!.length}",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const Text(
                                    " Like",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                navigateTo(
                                    context,
                                    CommentsPage(
                                      cubit: cubit,
                                      currentPostIndex: index,
                                    ));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    cubit.forumModel!.data![index]
                                        .forumComments!.length
                                        .toString(),
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const Text(
                                    " Replies",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget inkWell(String text, onTap, ForumsAllCubit cubit, int index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: cubit.currentIndex == index
                  ? buttonColor
                  : Colors.transparent,
              border: Border.all(
                color: cubit.currentIndex == index ? buttonColor : Colors.grey,
                width: 2,
              )),
          width: 120,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                text,
                style: TextStyle(
                    color: cubit.currentIndex == index
                        ? Colors.white
                        : Colors.grey,
                    fontSize: 18,
                    fontWeight: cubit.currentIndex == index
                        ? FontWeight.bold
                        : FontWeight.w400),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CommentsPage extends StatelessWidget {
  final int currentPostIndex;
  final ForumsAllCubit cubit;

  CommentsPage({required this.cubit, required this.currentPostIndex, Key? key})
      : super(key: key);

  TextEditingController commentController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Comments of ${cubit.forumModel!.data![currentPostIndex].title}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cubit
                    .forumModel!.data![currentPostIndex].forumComments!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(cubit.forumModel!.data![currentPostIndex]
                            .forumComments![index].comment!),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: defaultFormField(
                    controller: commentController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) {
                        "Comment is required";
                      }
                      return null;
                    }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cubit.postComment(
                            context: context,
                            forumId: cubit
                                .forumModel!.data![currentPostIndex].forumId!,
                            comment: commentController.text);
                      }
                    },
                    child: Text(
                      "Send comment",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

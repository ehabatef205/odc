import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/odc_web/modules/post/cubit/cubit.dart';
import 'package:odc/odc_web/modules/post/cubit/states.dart';
import 'package:odc/shared/components/components.dart';
import 'package:odc/shared/components/constants.dart';

class PostScreen extends StatelessWidget {
  PostScreen({Key? key}) : super(key: key);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCubit(),
      child: BlocConsumer<PostCubit, PostStates>(
        listener: (context, state) {},
        builder: (context, state) {
          PostCubit cubit = PostCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text("Create New Post"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: InkWell(
                          onTap: () {
                            cubit.chooseImage();
                          },
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: buttonColor,
                              ),
                            ),
                            child: cubit.image == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.add,
                                        color: buttonColor,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Add Photo",
                                        style: TextStyle(color: buttonColor),
                                      ),
                                    ],
                                  )
                                : Image(
                                    image: FileImage(
                                      File(cubit.image!.path),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Title",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultFormField(
                          controller: titleController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Title is required";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Description",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultFormField(
                          controller: descriptionController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Description is required";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              cubit.postPost(
                                  context: context,
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  imageBase64: cubit.img64);
                            }
                          },
                          text: "Post")
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

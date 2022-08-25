import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/odc_web/modules/notification/cubit/cubit.dart';
import 'package:odc/odc_web/modules/notification/cubit/states.dart';
import 'package:odc/shared/components/constants.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit()..getData(),
      child: BlocConsumer<NotificationCubit, NotificationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NotificationCubit cubit = NotificationCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.userModel != null,
            builder: (context) => list(context, cubit),
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

  Widget list(BuildContext context, NotificationCubit cubit) {
    return ListView.builder(
      itemCount: cubit.userModel!.data!.userNotification!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              ListTile(
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://res.cloudinary.com/lms07/image/upload/v1645954589/avatar/6214b94ad832b0549b436264_avatar1645954588291.png",
                      ),
                      fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                title: Text(cubit.userModel!.data!.userNotification![index].message!),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(cubit.userModel!.data!.userNotification![index].createdAt!),
                ),
              ),
              const Divider(
                color: Colors.grey,
              )
            ],
          ),
        );
      },
    );
  }
}

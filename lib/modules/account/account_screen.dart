import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/modules/account/cubit/cubit.dart';
import 'package:odc/modules/account/cubit/states.dart';
import 'package:odc/shared/components/components.dart';
import 'package:odc/shared/components/constants.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountStates>(
      listener: (context, state) {
        if (state is SuccessChangeNameState) {
          AccountCubit.get(context).getData();
        } else if (state is SuccessChangeEmailState) {
          AccountCubit.get(context).getData();
        }
      },
      builder: (context, state) {
        AccountCubit cubit = AccountCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.userModel != null,
            builder: (context) => Center(
                  child: SafeArea(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/rectangle.png"),
                                    fit: BoxFit.fill)),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              decoration: const BoxDecoration(
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListView(
                              children: [
                                const Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialogName(context, cubit);
                                  },
                                  child: Card(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.black, width: 0.5)),
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.change_circle_outlined,
                                            color: Colors.teal,
                                          ),
                                          title: Text("Change Name"),
                                          trailing: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.teal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Card(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.black, width: 0.5)),
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.change_circle_outlined,
                                            color: Colors.teal,
                                          ),
                                          title: Text("Change Email"),
                                          trailing: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.teal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        cubit.userModel!.data!.imageUrl!),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(200),
                                ),
                              ),
                              Text(
                                "${cubit.userModel!.data!.firstName} ${cubit.userModel!.data!.lastName}",
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
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
    );
  }

  void showDialogName(
    BuildContext context,
    AccountCubit cubit,
  ) {
    Size size = MediaQuery.of(context).size;

    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Column(
              children: [
                const Text("Change Your name"),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "First Name",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    defaultFormField(
                        controller: firstNameController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "First Name is required";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Last Name",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    defaultFormField(
                        controller: lastNameController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Last Name is required";
                          }
                          return null;
                        }),
                  ],
                )
              ],
            ),
            actions: <Widget>[
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
                        cubit.changeName(
                          context: context,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                        );
                      },
                      child: const Text(
                        "Change Name",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }

  void showDialogEmail(
    BuildContext context,
    AccountCubit cubit,
  ) {
    Size size = MediaQuery.of(context).size;

    TextEditingController emailController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Column(
              children: [
                const Text("Change Your Email"),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Email is required";
                          }
                          return null;
                        }),
                  ],
                )
              ],
            ),
            actions: <Widget>[
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
                        cubit.changeEmail(
                          context: context,
                          email: emailController.text,
                        );
                      },
                      child: const Text(
                        "Change Email",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}

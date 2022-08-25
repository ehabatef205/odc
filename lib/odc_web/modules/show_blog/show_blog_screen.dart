import 'package:flutter/material.dart';
import 'package:odc/models/blog_model.dart';

class ShowBloScreen extends StatelessWidget {
  final BlogModel blogModel;
  final int index;

  const ShowBloScreen({required this.blogModel, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            blogModel.data!.plants![index].imageUrl != ""? Container(
              width: size.width * 0.6,
              height: size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://lavie.orangedigitalcenteregypt.com${blogModel.data!.plants![index].imageUrl}",
                  ),
                  fit: BoxFit.fill
                ),
              ),
            ) : Container(
              width: double.infinity,
              height: size.height * 0.3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background.png"),
                    fit: BoxFit.fill
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    Text(
                      blogModel.data!.plants![index].name!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      blogModel.data!.plants![index]
                          .description!,
                      style: const TextStyle(
                        fontSize: 18,),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

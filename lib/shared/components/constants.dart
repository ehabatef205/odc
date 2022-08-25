import 'package:flutter/material.dart';

Color greyColor = const Color.fromRGBO(111, 111, 111, 1);
const Color buttonColor = Color.fromRGBO(26, 188, 0, 1);

void printFullText({required String text}) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token;

String? uId;

List<String> names = [];
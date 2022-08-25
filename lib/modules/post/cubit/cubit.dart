import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:odc/modules/post/cubit/states.dart';
import 'package:odc/shared/components/components.dart';
import 'package:odc/shared/components/constants.dart';
import 'package:odc/shared/network/remote/dio_helper.dart';

class PostCubit extends Cubit<PostStates> {
  PostCubit() : super(InitialPostState());

  static PostCubit get(context) => BlocProvider.of(context);

  XFile? image;

  String img64 = '';

  void chooseImage() async {
    emit(LoadingImagePostState());
    image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    File imagefile = File(image!.path);

    Uint8List bytes = await imagefile.readAsBytes();

    img64 = base64.encode(bytes);

    print(img64);

    emit(SuccessImagePostState());
  }

  void postPost({
    required context,
    required String title,
    required String description,
    required String imageBase64,
  }) {
    emit(LoadingPostState());
    DioHelper.postData(
      url: "/api/v1/forums",
      data: {
        "title": title,
        "description": description,
        "imageBase64": "data:image/jpeg;base64,$imageBase64",
      },
      token: token,
    ).then((value) {
      navigatePop(context);
      emit(SuccessPostState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorPostState());
    });
  }
}

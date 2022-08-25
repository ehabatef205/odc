import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/models/blog_model.dart';
import 'package:odc/modules/blog/cubit/states.dart';
import 'package:odc/shared/components/constants.dart';
import 'package:odc/shared/network/remote/dio_helper.dart';

class BlogCubit extends Cubit<BlogStates> {
  BlogCubit() : super(InitialBlogState());

  static BlogCubit get(context) => BlocProvider.of(context);

  BlogModel? blogModel;

  void getBlog() {
    emit(LoadingBlogState());

    DioHelper.getData(url: "/api/v1/products/blogs", token: token)
        .then((value) {
      blogModel = BlogModel.fromJson(value.data);
      print(value.data);
      emit(SuccessBlogState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorBlogState());
    });
  }
}

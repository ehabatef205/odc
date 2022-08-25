import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/models/forum_model.dart';
import 'package:odc/modules/forums_all/cubit/states.dart';
import 'package:odc/shared/components/components.dart';
import 'package:odc/shared/components/constants.dart';
import 'package:odc/shared/network/remote/dio_helper.dart';

class ForumsAllCubit extends Cubit<ForumsAllStates> {
  ForumsAllCubit() : super(ForumsAllInitialState());

  static ForumsAllCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  ForumModel? forumModel;

  void getForumsAll() {
    emit(ForumsAllLoadingState());

    DioHelper.getData(
      url: "/api/v1/forums",
      token: token,
    ).then((value) {
      forumModel = ForumModel.fromJson(value.data);
      emit(SuccessForumsStates());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorForumsStates());
    });
  }

  void getForumsMe() {
    emit(ForumsAllLoadingState());

    DioHelper.getData(
      url: "/api/v1/forums/me",
      token: token,
    ).then((value) {
      forumModel = ForumModel.fromJson(value.data);
      emit(SuccessForumsStates());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorForumsStates());
    });
  }

  void changeScreen(int index) {
    currentIndex = index;
    forumModel = null;
    if (currentIndex == 0) {
      getForumsAll();
    } else {
      getForumsMe();
    }

    emit(ChangeBottomStates());
  }

  void postComment({
    required context,
    required String forumId,
    required String comment,
  }) {
    emit(LoadingLikeForumState());
    DioHelper.postData(
      url: "/api/v1/forums/$forumId/comment",
      data: {
        "comment": comment,
      },
      token: token,
    ).then((value) {
      if (currentIndex == 0) {
        getForumsAll();
      } else {
        getForumsMe();
      }
      navigatePop(context);
      emit(SuccessLikeForumState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorLikeForumState());
    });
  }

  void postLike({
    required String forumId,
  }) {
    emit(LoadingLikeForumState());
    DioHelper.postData(
      url: "/api/v1/forums/$forumId/like",
      data: {},
      token: token,
    ).then((value) {
      getForumsAll();
      getForumsMe();
      emit(SuccessLikeForumState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorLikeForumState());
    });
  }
}

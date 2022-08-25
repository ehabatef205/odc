import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/models/user_model.dart';
import 'package:odc/odc_web/modules/notification/cubit/states.dart';
import 'package:odc/shared/components/constants.dart';
import 'package:odc/shared/network/remote/dio_helper.dart';

class NotificationCubit extends Cubit<NotificationStates> {
  NotificationCubit() : super(InitialNotificationState());

  UserModel? userModel;

  static NotificationCubit get(context) => BlocProvider.of(context);

  void getData() {
    emit(LoadingNotificationState());

    DioHelper.getData(url: "/api/v1/user/me", token: token).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(SuccessNotificationState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorNotificationState());
    });
  }
}

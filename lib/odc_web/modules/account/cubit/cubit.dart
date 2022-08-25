import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/models/user_model.dart';
import 'package:odc/odc_web/modules/account/cubit/states.dart';
import 'package:odc/shared/components/constants.dart';
import 'package:odc/shared/network/remote/dio_helper.dart';

class AccountCubit extends Cubit<AccountStates> {
  AccountCubit() : super(InitialAccountState());

  static AccountCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getData() {
    emit(LoadingAccountState());

    DioHelper.getData(url: "/api/v1/user/me", token: token).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(SuccessAccountState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorAccountState());
    });

    emit(FinalAccountState());
  }

  void changeProfile({
    required context,
    required String firstName,
    required String lastName,
    required String email,
    required String address,
  }) {
    emit(LoadingChangeNameState());
    DioHelper.patchData(
      url: "/api/v1/user/me",
      data: {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "address": address,
      },
      token: token,
    ).then((value) {
      emit(SuccessChangeNameState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorChangeNameState());
    });
  }
}

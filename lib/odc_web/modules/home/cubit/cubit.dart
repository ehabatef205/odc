import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/models/plant_model.dart';
import 'package:odc/models/protuct_model.dart';
import 'package:odc/models/search_model.dart';
import 'package:odc/models/seed_model.dart';
import 'package:odc/models/tool_model.dart';
import 'package:odc/odc_web/modules/home/cubit/states.dart';
import 'package:odc/shared/components/constants.dart';
import 'package:odc/shared/network/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialStates());

  static HomeCubit get(context) => BlocProvider.of(context);

  ProductModel? productModel;

  SeedModel? seedModel;

  ToolModel? toolModel;

  PlantModel? plantModel;

  SearchModel? searchModel;

  var model;

  int currentIndex = 0;

  List<String> listString = [
    "Tools",
    "Seeds",
    "Low Light Plants",
    "Bright Light Plants",
  ];

  void getProducts() {
    emit(LoadingHomeStates());

    DioHelper.getData(url: "/api/v1/products", token: token).then((value) {
      productModel = ProductModel.fromJson(value.data);
      emit(SuccessHomeStates());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorHomeStates());
    });
  }

  void getSeeds() {
    emit(LoadingHomeStates());

    DioHelper.getData(url: "/api/v1/seeds", token: token).then((value) {
      seedModel = SeedModel.fromJson(value.data);
      emit(SuccessHomeStates());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorHomeStates());
    });
  }

  void getTools() {
    emit(LoadingHomeStates());

    DioHelper.getData(url: "/api/v1/tools", token: token).then((value) {
      toolModel = ToolModel.fromJson(value.data);
      emit(SuccessHomeStates());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorHomeStates());
    });
  }

  void getPlants() {
    emit(LoadingHomeStates());

    DioHelper.getData(url: "/api/v1/plants", token: token).then((value) {
      plantModel = PlantModel.fromJson(value.data);
      emit(SuccessHomeStates());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorHomeStates());
    });
  }

  void changeHome(index) {
    currentIndex = index;
    if (currentIndex == 0) {
      model = productModel;
    } else if (currentIndex == 1) {
      model = plantModel;
    } else if (currentIndex == 2) {
      model = seedModel;
    } else {
      model = toolModel;
    }

    emit(ChangeHomeStates());
  }

  void getNamesForSearch() {
    emit(LoadingSearchStates());

    DioHelper.getData(url: "/api/v1/products/filters", token: token)
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      for (int i = 0; i < searchModel!.data!.plants!.length; i++) {
        names.add(searchModel!.data!.plants![i].name!);
      }

      for (int i = 0; i < searchModel!.data!.seeds!.length; i++) {
        names.add(searchModel!.data!.seeds![i].name!);
      }

      for (int i = 0; i < searchModel!.data!.tools!.length; i++) {
        names.add(searchModel!.data!.tools![i].name!);
      }

      emit(SuccessSearchStates());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorSearchStates());
    });
  }
}

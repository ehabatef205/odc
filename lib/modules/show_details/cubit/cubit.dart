import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/modules/show_details/cubit/states.dart';

class ShowDetailsCubit extends Cubit<ShowDetailsStates>{
  ShowDetailsCubit() : super(InitialShowDetailsState());

  static ShowDetailsCubit get(context) => BlocProvider.of(context);
}
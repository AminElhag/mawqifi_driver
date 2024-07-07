import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mawqifi_driver/common_model/error_response.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
}

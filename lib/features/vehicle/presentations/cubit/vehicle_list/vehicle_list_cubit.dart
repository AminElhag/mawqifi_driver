import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mawqifi_driver/common/globs.dart';
import 'package:mawqifi_driver/common/service_call.dart';
import 'package:mawqifi_driver/common_model/error_response.dart';
import 'package:mawqifi_driver/common_model/vehicle_model.dart';
import 'package:meta/meta.dart';

part 'vehicle_list_state.dart';

class VehicleListCubit extends Cubit<VehicleListState> {
  VehicleListCubit() : super(VehicleListInitial());

  void getVehiclesList(int userId) {
    emit(VehicleListHUDState());
    try {
      ServiceCall.get(
        {"user_id": userId.toString()},
        SVKey.svVehicle,
        withFailure: (response) async {
          emit(VehicleListErrorState(response));
        },
        withSuccess: (response) async {
          if (response.statusCode == HttpStatus.ok) {
            Iterable l = json.decode(response.body);
            List<VehicleModel> nps = List<VehicleModel>.from(
                l.map((model) => VehicleModel.fromJson(model)));
            emit(VehicleListApiResultState(items: nps));
            emit(VehicleListInitial());
          } else {
            emit(VehicleListErrorApiResultState(
              ErrorResponse.fromJson(jsonDecode(response.body)),
            ));
          }
        },
      );
    } catch (e) {
      emit(VehicleListErrorState(e.toString()));
    }
  }
}

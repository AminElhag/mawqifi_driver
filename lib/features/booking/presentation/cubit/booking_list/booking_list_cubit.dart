import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mawqifi_driver/common/globs.dart';
import 'package:mawqifi_driver/common/service_call.dart';
import 'package:mawqifi_driver/common_model/booking_item_model.dart';
import 'package:mawqifi_driver/common_model/error_response.dart';

part 'booking_list_state.dart';

class BookingListCubit extends Cubit<BookingListState> {
  BookingListCubit() : super(BookingListInitial());

  void getBookingList(int userId, int typeId) {
    emit(BookingListHUDState());
    if (kDebugMode) {
      print(typeId);
    }
    try {
      ServiceCall.get(
        {"user_id": userId.toString(), "type_id": typeId.toString()},
        SVKey.svDriveBooking,
        isTokenApi: true,
        withFailure: (response) async {
          emit(BookingListErrorState(response));
        },
        withSuccess: (response) async {
          if (kDebugMode) {
            print(response);
          }
          if (response.statusCode == HttpStatus.ok) {
            Iterable l = json.decode(response.body);
            List<BookingItemModel?> nps = List<BookingItemModel>.from(
                l.map((model) => BookingItemModel.fromJson(model)));
            emit(BookingListGetListApiResultState(items: nps));
            emit(BookingListInitial());
          } else {
            emit(BookingListErrorApiResultState(
                ErrorResponse.fromJson(jsonDecode(response.body))));
          }
        },
      );
    } catch (e) {
      emit(BookingListErrorState(e.toString()));
    }
  }

  void acceptOrder(int bookingId, int driverId) {
    emit(BookingListHUDState());
    try {
      ServiceCall.post(
        {"user_id": driverId.toString(), "booking_id": bookingId.toString()},
        SVKey.svAcceptBooking,
        isTokenApi: true,
        withFailure: (response) async {
          emit(BookingListErrorState(response));
        },
        withSuccess: (response) async {
          if (kDebugMode) {
            print(response);
          }
          if (response.statusCode == HttpStatus.ok) {
            emit(BookingAcceptApiResultState());
            emit(BookingListInitial());
          } else {
            emit(BookingListErrorApiResultState(
                ErrorResponse.fromJson(jsonDecode(response.body))));
          }
        },
      );
    } catch (e) {
      emit(BookingListErrorState(e.toString()));
    }
  }

  void completeOrder(int bookingId, int driverId) {

    emit(BookingListHUDState());
    try {
      ServiceCall.post(
        {"user_id": driverId.toString(), "booking_id": bookingId.toString()},
        SVKey.svCompleteBooking,
        isTokenApi: true,
        withFailure: (response) async {
          emit(BookingListErrorState(response));
        },
        withSuccess: (response) async {
          if (kDebugMode) {
            print(response);
          }
          if (response.statusCode == HttpStatus.ok) {
            emit(BookingCompleteApiResultState());
            emit(BookingListInitial());
          } else {
            emit(BookingListErrorApiResultState(
                ErrorResponse.fromJson(jsonDecode(response.body))));
          }
        },
      );
    } catch (e) {
      emit(BookingListErrorState(e.toString()));
    }

  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawqifi_driver/common/color-extension.dart';
import 'package:mawqifi_driver/common/globs.dart';
import 'package:mawqifi_driver/common_model/booking_item_model.dart';
import 'package:mawqifi_driver/common_widget/booking_item.dart';
import 'package:mawqifi_driver/common_widget/booking_progress_button.dart';
import 'package:mawqifi_driver/common_widget/nothing_to_show_widget.dart';
import 'package:mawqifi_driver/features/booking/presentation/cubit/booking_list/booking_list_cubit.dart';
import 'package:quickalert/quickalert.dart';

class BookingListPage extends StatefulWidget {
  const BookingListPage({super.key, required this.typeId});

  final int typeId;

  static route(int typeId) => MaterialPageRoute(
        builder: (context) => BookingListPage(
          typeId: typeId,
        ),
      );

  @override
  State<BookingListPage> createState() => _BookingListPageState();
}

class _BookingListPageState extends State<BookingListPage> {
  final List<BookingItemModel> items = [];

  @override
  void initState() {
    context
        .read<BookingListCubit>()
        .getBookingList(Globs.udValueInt(PreferenceKey.userId), widget.typeId);
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    context
        .read<BookingListCubit>()
        .getBookingList(Globs.udValueInt(PreferenceKey.userId), widget.typeId);
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<BookingListCubit>()
        .getBookingList(Globs.udValueInt(PreferenceKey.userId), widget.typeId);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: BlocConsumer<BookingListCubit, BookingListState>(
        listener: (context, state) {
          if (state is BookingListHUDState) {
            Globs.showHUD();
          } else if (state is BookingListErrorState) {
            Globs.hideHUD();
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Error',
              text: state.errorMessage,
              backgroundColor: Colors.black,
              titleColor: Colors.white,
              textColor: Colors.white,
            );
          } else if (state is BookingListErrorApiResultState) {
            Globs.hideHUD();
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: state.errorResponse.statusCode.toString(),
              text: state.errorResponse.message,
              backgroundColor: Colors.black,
              titleColor: Colors.white,
              textColor: Colors.white,
            );
          } else if (state is BookingListGetListApiResultState) {
            Globs.hideHUD();
            items.clear();
            if(state.items.isNotEmpty) items.addAll(state.items as Iterable<BookingItemModel>);
          } else if (state is BookingAcceptApiResultState) {
            Globs.hideHUD();
            setState(() {
              context.read<BookingListCubit>().getBookingList(
                  Globs.udValueInt(PreferenceKey.userId), widget.typeId);
            });
          } else if (state is BookingCompleteApiResultState) {
            Globs.hideHUD();
            setState(() {
              context.read<BookingListCubit>().getBookingList(
                  Globs.udValueInt(PreferenceKey.userId), widget.typeId);
            });
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: context.height - 210,
                child: (items.isNotEmpty)
                    ? ListView.builder(
                        itemCount: items.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var item = items[index];
                          return BookingItem(
                            bookingItemModel: item,
                            onPressed: () {
                              if (item.statusId ==
                                  BookingProgress.wanting.index) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.confirm,
                                  title: 'Accept',
                                  text: "You will accept order",
                                  backgroundColor: Colors.black,
                                  titleColor: Colors.white,
                                  textColor: Colors.white,
                                  onConfirmBtnTap: () {
                                    context
                                        .read<BookingListCubit>()
                                        .acceptOrder(
                                            item.id,
                                            Globs.udValueInt(
                                                PreferenceKey.userId));
                                  Navigator.pop(context);
                                    },
                                );
                              } else if (item.statusId ==
                                  BookingProgress.inProgress.index) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.confirm,
                                  title: 'Completed',
                                  text: "You will completed order",
                                  backgroundColor: Colors.black,
                                  titleColor: Colors.white,
                                  textColor: Colors.white,
                                  onConfirmBtnTap: () {
                                    context
                                        .read<BookingListCubit>()
                                        .completeOrder(
                                            item.id,
                                            Globs.udValueInt(
                                                PreferenceKey.userId));
                                    Navigator.pop(context);

                                  },
                                );
                              }
                            },
                          );
                        },
                      )
                    : const NothingToShowWidget(),
              ),
            ],
          );
        },
      ),
    );
  }
}

//WAITING(0), IN_PROGRESS(1), COMPLETED(2), CANCELED(3)
enum BookingType {
  waiting(typeId: 0),
  inProgress(typeId: 1),
  completedRequest(typeId: 2),
  canceled(typeId: 3);

  const BookingType({required this.typeId});

  final int typeId;

  int get id => typeId;
}

import 'package:flutter/material.dart';
import 'package:mawqifi_driver/common/color-extension.dart';
import 'package:mawqifi_driver/common_model/booking_item_model.dart';
import 'package:mawqifi_driver/common_widget/booking_progress_button.dart';

class BookingItem extends StatefulWidget {
  const BookingItem(
      {super.key, required this.bookingItemModel, required this.onPressed});

  final VoidCallback onPressed;
  final BookingItemModel bookingItemModel;

  @override
  State<BookingItem> createState() => _BookingItemState();
}

class _BookingItemState extends State<BookingItem> {
  String form = "";
  String until = "";
  String howMuch = "";

  @override
  void initState() {
    var hour = DateTime.parse(widget.bookingItemModel.from).toLocal().hour;
    var minute = DateTime.parse(widget.bookingItemModel.from).toLocal().minute;
    if (hour > 12) {
      hour = hour - 12;
      form = "$hour:$minute PM";
    } else {
      form = "$hour:$minute AM";
    }
    hour = DateTime.parse(widget.bookingItemModel.until).toLocal().hour;
    minute = DateTime.parse(widget.bookingItemModel.until).toLocal().minute;
    if (hour > 12) {
      hour = hour - 12;
      until = "$hour:$minute PM";
    } else {
      until = "$hour:$minute AM";
    }
    howMuch =
        "${DateTime.parse(widget.bookingItemModel.until).difference(DateTime.parse(widget.bookingItemModel.from)).inHours}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: widget.onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                (widget.bookingItemModel.vehicleModel!.carTypeId == 0)
                    ? const SizedBox(
                        width: 80,
                        child: Column(
                          children: [
                            ImageIcon(AssetImage("assets/img/hatchback.png")),
                            Text("Hatchback ")
                          ],
                        ),
                      )
                    : (widget.bookingItemModel.vehicleModel!.carTypeId == 1)
                        ? const SizedBox(
                            width: 80,
                            child: Column(
                              children: [
                                ImageIcon(AssetImage("assets/img/sedan.png")),
                                Text("Sedan")
                              ],
                            ),
                          )
                        : const SizedBox(
                            width: 80,
                            child: Column(
                              children: [
                                ImageIcon(AssetImage("assets/img/suv.png")),
                                Text("SUV")
                              ],
                            ),
                          ),
                Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(children: [
                        TextSpan(
                          text: widget.bookingItemModel.vehicleModel!.brand,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: TColor.primaryText),
                        ),
                        TextSpan(
                          text:
                              ' ${widget.bookingItemModel.vehicleModel!.model} ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: TColor.primaryText),
                        ),
                        TextSpan(
                          text: widget.bookingItemModel.vehicleModel!.plantNo,
                          style: TextStyle(color: TColor.primaryText),
                        ),
                      ]),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "$howMuch hours",
              maxLines: 2,
              style: TextStyle(color: TColor.secondaryText, fontSize: 12),
            ),
            BookingProgressButton(
                onPressed: widget.onPressed,
                statusId: widget.bookingItemModel.statusId)
          ],
        ),
      ),
    );
  }
}

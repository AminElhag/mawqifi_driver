import 'package:mawqifi_driver/common_model/vehicle_model.dart';

class BookingItemModel {
  final String imageUrl;
  final String name;
  final String longAddress;
  final double price;
  final String from;
  final String until;
  final int statusId;
  final int id;
  final VehicleModel? vehicleModel;

  BookingItemModel(
      {required this.imageUrl,
      required this.name,
      required this.longAddress,
      required this.price,
      required this.from,
      required this.until,
      required this.statusId,
      required this.id,
      required this.vehicleModel});

  factory BookingItemModel.fromJson(Map<String, dynamic> json) =>
      BookingItemModel(
        imageUrl: json['image_url'],
        name: json['name'],
        longAddress: json['long_address'],
        price: json['price'],
        from: json['from'],
        until: json['until'],
        statusId: json['status_id'],
        id: json['id'],
        vehicleModel: (json['vehicle'] != null)
            ? VehicleModel.fromJson(json['vehicle'])
            : null,
      );
}
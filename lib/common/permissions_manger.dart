import 'package:permission_handler/permission_handler.dart';

class PermissionsManger {
  static Future<void> askForLocationPermission() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.location,
    ].request();
  }

  static Future<void> askForNotificationPermission() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.notification,
    ].request();
  }
}

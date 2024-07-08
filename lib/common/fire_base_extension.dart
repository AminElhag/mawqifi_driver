import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mawqifi_driver/common/globs.dart';

class FireBaseExtension{
  static Future<void> getToken() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final deviceToken = await _fcm.getToken();
    Globs.udStringSet(deviceToken?? "", PreferenceKey.fcmToken);
    print("token = " + deviceToken.toString());
  }
}
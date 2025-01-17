// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBC8LC1BKs5AqR0QZsye9p0fniFKotsJno',
    appId: '1:365914491686:web:2910e6daebaf97c50e4fe7',
    messagingSenderId: '365914491686',
    projectId: 'mawqifi-275a5',
    authDomain: 'mawqifi-275a5.firebaseapp.com',
    storageBucket: 'mawqifi-275a5.appspot.com',
    measurementId: 'G-4R4375Z8ZS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCR3McR4SsORot52EkD5othJHOCNekaQM8',
    appId: '1:365914491686:android:be4abc5237092fd60e4fe7',
    messagingSenderId: '365914491686',
    projectId: 'mawqifi-275a5',
    storageBucket: 'mawqifi-275a5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDPbU3jq45yNuANYE84Y5eC7QsprFc8AT8',
    appId: '1:365914491686:ios:9eb6e35c8d4c0d5f0e4fe7',
    messagingSenderId: '365914491686',
    projectId: 'mawqifi-275a5',
    storageBucket: 'mawqifi-275a5.appspot.com',
    iosBundleId: 'com.example.mawqifiDriver',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDPbU3jq45yNuANYE84Y5eC7QsprFc8AT8',
    appId: '1:365914491686:ios:9eb6e35c8d4c0d5f0e4fe7',
    messagingSenderId: '365914491686',
    projectId: 'mawqifi-275a5',
    storageBucket: 'mawqifi-275a5.appspot.com',
    iosBundleId: 'com.example.mawqifiDriver',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBC8LC1BKs5AqR0QZsye9p0fniFKotsJno',
    appId: '1:365914491686:web:b7862c57ca1b97af0e4fe7',
    messagingSenderId: '365914491686',
    projectId: 'mawqifi-275a5',
    authDomain: 'mawqifi-275a5.firebaseapp.com',
    storageBucket: 'mawqifi-275a5.appspot.com',
    measurementId: 'G-GXYJFH661Q',
  );
}

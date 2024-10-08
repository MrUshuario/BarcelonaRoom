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
    apiKey: 'AIzaSyA4BgYYR_6MI0V_UdTnzQriXrj6rgeiR6U',
    appId: '1:767436123138:web:eb5b73e60dd32dc8448b1b',
    messagingSenderId: '767436123138',
    projectId: 'pruebavendecasa',
    authDomain: 'pruebavendecasa.firebaseapp.com',
    storageBucket: 'pruebavendecasa.appspot.com',
    measurementId: 'G-WG85YRFRLS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD1LeAqii10bxjXP93AYFXgPehI0H99k0g',
    appId: '1:767436123138:android:c9f9577684e4c68d448b1b',
    messagingSenderId: '767436123138',
    projectId: 'pruebavendecasa',
    storageBucket: 'pruebavendecasa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDP_GJcbyCAuyUdFucVlHZ5w6TtL508LTw',
    appId: '1:767436123138:ios:854413259359b9ca448b1b',
    messagingSenderId: '767436123138',
    projectId: 'pruebavendecasa',
    storageBucket: 'pruebavendecasa.appspot.com',
    iosBundleId: 'gov.es.barcelona.approom.barcelonaroom',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDP_GJcbyCAuyUdFucVlHZ5w6TtL508LTw',
    appId: '1:767436123138:ios:854413259359b9ca448b1b',
    messagingSenderId: '767436123138',
    projectId: 'pruebavendecasa',
    storageBucket: 'pruebavendecasa.appspot.com',
    iosBundleId: 'gov.es.barcelona.approom.barcelonaroom',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA4BgYYR_6MI0V_UdTnzQriXrj6rgeiR6U',
    appId: '1:767436123138:web:1422e670b4f06132448b1b',
    messagingSenderId: '767436123138',
    projectId: 'pruebavendecasa',
    authDomain: 'pruebavendecasa.firebaseapp.com',
    storageBucket: 'pruebavendecasa.appspot.com',
    measurementId: 'G-FFY8RNGWKS',
  );

}
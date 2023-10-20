// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZfQ5MJS_nxciABXe-l6SX9mcYuihxFPY',
    appId: '1:1090655552004:android:66d66ce05d0aed1f152b51',
    messagingSenderId: '1090655552004',
    projectId: 'yourfish-app',
    storageBucket: 'yourfish-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD5j-O99mpvt71ASP_x4ScXjSbE7_2Mbk4',
    appId: '1:1090655552004:ios:2531c81afe170ce8152b51',
    messagingSenderId: '1090655552004',
    projectId: 'yourfish-app',
    storageBucket: 'yourfish-app.appspot.com',
    androidClientId: '1090655552004-7mvjovp0p6l1gpqj13csbfdnaeaenrok.apps.googleusercontent.com',
    iosClientId: '1090655552004-84mj50fuqgp3o15t3vpacajsil5eptac.apps.googleusercontent.com',
    iosBundleId: 'com.yourfish',
  );
}

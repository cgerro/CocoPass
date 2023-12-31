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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBeY5PREPofa1TPklZv40DiKBZMzBtUYXg',
    appId: '1:203433159701:web:268b97de8584562618321c',
    messagingSenderId: '203433159701',
    projectId: 'thermal-micron-396807',
    authDomain: 'thermal-micron-396807.firebaseapp.com',
    storageBucket: 'thermal-micron-396807.appspot.com',
    measurementId: 'G-RG243HHCK1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQkJ-7vlAocYXc49E-fF5Qb0EH-VJ38vE',
    appId: '1:203433159701:android:01455e1e935e440c18321c',
    messagingSenderId: '203433159701',
    projectId: 'thermal-micron-396807',
    storageBucket: 'thermal-micron-396807.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCh0RqOHx979RBTftKpmIRdNpFP8LfzNFk',
    appId: '1:203433159701:ios:04fb6e8d6c05013a18321c',
    messagingSenderId: '203433159701',
    projectId: 'thermal-micron-396807',
    storageBucket: 'thermal-micron-396807.appspot.com',
    iosClientId: '203433159701-96a9da95uokf0l33ge1ak1of9s3sc1is.apps.googleusercontent.com',
    iosBundleId: 'com.example.cocopass',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCh0RqOHx979RBTftKpmIRdNpFP8LfzNFk',
    appId: '1:203433159701:ios:4ecb137c86c60d4518321c',
    messagingSenderId: '203433159701',
    projectId: 'thermal-micron-396807',
    storageBucket: 'thermal-micron-396807.appspot.com',
    iosClientId: '203433159701-d4m79476h8r7r8lhcsgv823i12ardptp.apps.googleusercontent.com',
    iosBundleId: 'com.example.cocopass.RunnerTests',
  );
}

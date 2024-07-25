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
    apiKey: 'AIzaSyDoCb4pNjUR5P2cgWkcy4BPdzFcLLoydhk',
    appId: '1:753914104366:web:b390ff76f22d374c2f2dbf',
    messagingSenderId: '753914104366',
    projectId: 'catatansehatku02',
    authDomain: 'catatansehatku02.firebaseapp.com',
    storageBucket: 'catatansehatku02.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBU5CZnPMI2vGrdwFUTwavbokrDDeoe9Fs',
    appId: '1:753914104366:android:05ed5ce3a2f522332f2dbf',
    messagingSenderId: '753914104366',
    projectId: 'catatansehatku02',
    storageBucket: 'catatansehatku02.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-e2FOSysfPQY2352Hv-ftkmJ0GcAFrrE',
    appId: '1:753914104366:ios:387dc9f9a637caae2f2dbf',
    messagingSenderId: '753914104366',
    projectId: 'catatansehatku02',
    storageBucket: 'catatansehatku02.appspot.com',
    iosBundleId: 'com.example.catatanSehatKu',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB-e2FOSysfPQY2352Hv-ftkmJ0GcAFrrE',
    appId: '1:753914104366:ios:387dc9f9a637caae2f2dbf',
    messagingSenderId: '753914104366',
    projectId: 'catatansehatku02',
    storageBucket: 'catatansehatku02.appspot.com',
    iosBundleId: 'com.example.catatanSehatKu',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDoCb4pNjUR5P2cgWkcy4BPdzFcLLoydhk',
    appId: '1:753914104366:web:87fe8cad9b7ec6532f2dbf',
    messagingSenderId: '753914104366',
    projectId: 'catatansehatku02',
    authDomain: 'catatansehatku02.firebaseapp.com',
    storageBucket: 'catatansehatku02.appspot.com',
  );
}

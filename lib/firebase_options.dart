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
        return windows;
      // throw UnsupportedError(
      //   'DefaultFirebaseOptions have not been configured for windows - '
      //   'you can reconfigure this by running the FlutterFire CLI again.',
      // );
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
    apiKey: 'AIzaSyDaS-1jburWStxwU8NuPEwrsebGiTqoFFE',
    appId: '1:218305711511:web:fbed6fcea85c41acf288d2',
    messagingSenderId: '218305711511',
    projectId: 'narutoarena-c6ca7',
    authDomain: 'narutoarena-c6ca7.firebaseapp.com',
    storageBucket: 'narutoarena-c6ca7.appspot.com',
    measurementId: 'G-ZM0PK1XL43',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDaS-1jburWStxwU8NuPEwrsebGiTqoFFE',
    appId: '1:218305711511:web:fbed6fcea85c41acf288d2',
    messagingSenderId: '218305711511',
    projectId: 'narutoarena-c6ca7',
    authDomain: 'narutoarena-c6ca7.firebaseapp.com',
    storageBucket: 'narutoarena-c6ca7.appspot.com',
    measurementId: 'G-ZM0PK1XL43',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCrzLgyRbIwYI2IZOOJVWfHrdIeZMB9DYo',
    appId: '1:218305711511:android:f86ccb7d3c5f0382f288d2',
    messagingSenderId: '218305711511',
    projectId: 'narutoarena-c6ca7',
    storageBucket: 'narutoarena-c6ca7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCBdr-jeiFI9Yu2ByDpflurfMISGDGNeeM',
    appId: '1:218305711511:ios:98b594c57610a539f288d2',
    messagingSenderId: '218305711511',
    projectId: 'narutoarena-c6ca7',
    storageBucket: 'narutoarena-c6ca7.appspot.com',
    iosClientId:
        '218305711511-5dv8t4ntfcn86jva22b37lapbvli7c2f.apps.googleusercontent.com',
    iosBundleId: 'com.example.theTestNarutoArena',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCBdr-jeiFI9Yu2ByDpflurfMISGDGNeeM',
    appId: '1:218305711511:ios:98b594c57610a539f288d2',
    messagingSenderId: '218305711511',
    projectId: 'narutoarena-c6ca7',
    storageBucket: 'narutoarena-c6ca7.appspot.com',
    iosClientId:
        '218305711511-5dv8t4ntfcn86jva22b37lapbvli7c2f.apps.googleusercontent.com',
    iosBundleId: 'com.example.theTestNarutoArena',
  );
}

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
    apiKey: 'AIzaSyBX9zyNuNUTf-K5WBoU9jYNGfHo6HK8Sf0',
    appId: '1:309256412948:web:939b5257175ffea00d6c01',
    messagingSenderId: '309256412948',
    projectId: 'mi-chat-2e92a',
    authDomain: 'mi-chat-2e92a.firebaseapp.com',
    storageBucket: 'mi-chat-2e92a.appspot.com',
    measurementId: 'G-2WMBCQNQQ4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD1un4ryDqb52ti2kLYDOvJX8w62TuU5T0',
    appId: '1:309256412948:android:183fc250720c46ad0d6c01',
    messagingSenderId: '309256412948',
    projectId: 'mi-chat-2e92a',
    storageBucket: 'mi-chat-2e92a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3NUUJgrGSdJVZe9FUr_s2PVeydl0tnss',
    appId: '1:309256412948:ios:6e9b9a836875765b0d6c01',
    messagingSenderId: '309256412948',
    projectId: 'mi-chat-2e92a',
    storageBucket: 'mi-chat-2e92a.appspot.com',
    iosBundleId: 'lk.mishan.michat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC3NUUJgrGSdJVZe9FUr_s2PVeydl0tnss',
    appId: '1:309256412948:ios:6e9b9a836875765b0d6c01',
    messagingSenderId: '309256412948',
    projectId: 'mi-chat-2e92a',
    storageBucket: 'mi-chat-2e92a.appspot.com',
    iosBundleId: 'lk.mishan.michat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBX9zyNuNUTf-K5WBoU9jYNGfHo6HK8Sf0',
    appId: '1:309256412948:web:6131e913f6df3c2f0d6c01',
    messagingSenderId: '309256412948',
    projectId: 'mi-chat-2e92a',
    authDomain: 'mi-chat-2e92a.firebaseapp.com',
    storageBucket: 'mi-chat-2e92a.appspot.com',
    measurementId: 'G-6SFZ01G140',
  );
}

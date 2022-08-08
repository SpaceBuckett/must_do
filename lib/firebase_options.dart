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
    apiKey: 'AIzaSyD0sm8Ww-z5wfO7KMz3rlMutSs9qob7SWo',
    appId: '1:868434574102:web:3d8b199eec67bf24aa2e37',
    messagingSenderId: '868434574102',
    projectId: 'godo-39f5e',
    authDomain: 'godo-39f5e.firebaseapp.com',
    storageBucket: 'godo-39f5e.appspot.com',
    measurementId: 'G-Q5VW9QEE7F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCORICWsv9BwHG_XEjk9jt6UGUc-U0uBZc',
    appId: '1:868434574102:android:45a45743b51dc565aa2e37',
    messagingSenderId: '868434574102',
    projectId: 'godo-39f5e',
    storageBucket: 'godo-39f5e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4pIPeht-yE_RSn4TcOeyX0-qgWE7B8gs',
    appId: '1:868434574102:ios:7ef2d3a5c69bf816aa2e37',
    messagingSenderId: '868434574102',
    projectId: 'godo-39f5e',
    storageBucket: 'godo-39f5e.appspot.com',
    iosClientId: '868434574102-g5uha7jvp0s2nmthfm0qqft1u9akl9mg.apps.googleusercontent.com',
    iosBundleId: 'com.example.mustDo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB4pIPeht-yE_RSn4TcOeyX0-qgWE7B8gs',
    appId: '1:868434574102:ios:7ef2d3a5c69bf816aa2e37',
    messagingSenderId: '868434574102',
    projectId: 'godo-39f5e',
    storageBucket: 'godo-39f5e.appspot.com',
    iosClientId: '868434574102-g5uha7jvp0s2nmthfm0qqft1u9akl9mg.apps.googleusercontent.com',
    iosBundleId: 'com.example.mustDo',
  );
}

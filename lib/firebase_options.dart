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
    apiKey: 'AIzaSyA3VImUxsf0gTvP26UNKj14CsPAb2DgMvQ',
    appId: '1:907909233426:web:4a85a59ab80428af4a11cb',
    messagingSenderId: '907909233426',
    projectId: 'clubapp-a2bdb',
    authDomain: 'clubapp-a2bdb.firebaseapp.com',
    storageBucket: 'clubapp-a2bdb.appspot.com',
    measurementId: 'G-M8EZFKLQFQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD_G1SrPbM-amyaAiMlMUaIK2PcRJRKJEs',
    appId: '1:907909233426:android:8d8a2210cc8741934a11cb',
    messagingSenderId: '907909233426',
    projectId: 'clubapp-a2bdb',
    storageBucket: 'clubapp-a2bdb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBatG-wFhOX1TOWoDcLAS1ufwNzBHe6Ze0',
    appId: '1:907909233426:ios:0821aface6b6c2434a11cb',
    messagingSenderId: '907909233426',
    projectId: 'clubapp-a2bdb',
    storageBucket: 'clubapp-a2bdb.appspot.com',
    iosClientId: '907909233426-ve7qs27dt7aipfjmrngrg9j1g0ftaqb1.apps.googleusercontent.com',
    iosBundleId: 'com.example.clubApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBatG-wFhOX1TOWoDcLAS1ufwNzBHe6Ze0',
    appId: '1:907909233426:ios:8ccaf7610593cebf4a11cb',
    messagingSenderId: '907909233426',
    projectId: 'clubapp-a2bdb',
    storageBucket: 'clubapp-a2bdb.appspot.com',
    iosClientId: '907909233426-t3puhnqj0cb274gvju43q2ubrdr03sol.apps.googleusercontent.com',
    iosBundleId: 'com.example.clubApp.RunnerTests',
  );
}

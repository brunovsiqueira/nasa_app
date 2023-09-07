// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyCblnK_YB_A6lKfVWQHP7G7aobQYPtoo_I',
    appId: '1:484473872047:web:3122fa88ee28b0f5a83e5a',
    messagingSenderId: '484473872047',
    projectId: 'nasa-app-1619',
    authDomain: 'nasa-app-1619.firebaseapp.com',
    storageBucket: 'nasa-app-1619.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJj1-mdsCq5JURIrzggMv-zOqrFUtsDqo',
    appId: '1:484473872047:android:e13b906df13d0937a83e5a',
    messagingSenderId: '484473872047',
    projectId: 'nasa-app-1619',
    storageBucket: 'nasa-app-1619.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBFe8iDG1R3syfOWH3SrDPVrT3-BwAbcX4',
    appId: '1:484473872047:ios:be97e2db45193c53a83e5a',
    messagingSenderId: '484473872047',
    projectId: 'nasa-app-1619',
    storageBucket: 'nasa-app-1619.appspot.com',
    iosClientId:
        '484473872047-4do0jhk6fhphnlo3kpjaabl2if8rgls5.apps.googleusercontent.com',
    iosBundleId: 'com.example.nasaApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBFe8iDG1R3syfOWH3SrDPVrT3-BwAbcX4',
    appId: '1:484473872047:ios:9b020e8291093a87a83e5a',
    messagingSenderId: '484473872047',
    projectId: 'nasa-app-1619',
    storageBucket: 'nasa-app-1619.appspot.com',
    iosClientId:
        '484473872047-97utkit8nquppjfrr6kfg4v48lmg2tgo.apps.googleusercontent.com',
    iosBundleId: 'com.example.nasaApp.RunnerTests',
  );
}

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
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
    apiKey: 'AIzaSyALvbxw8R5zXkHBVOy0OftaAK0d3SWMdUA',
    appId: '1:267557924375:android:b547dbadc0ef30087c7652',
    messagingSenderId: '267557924375',
    projectId: 'alawael-75154',
    storageBucket: 'alawael-75154.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBTgpMHCPuqI1durPLzM5Dajp_9Um4h0Fw',
    appId: '1:267557924375:ios:1746ffb9fac1d4357c7652',
    messagingSenderId: '267557924375',
    projectId: 'alawael-75154',
    storageBucket: 'alawael-75154.appspot.com',
    androidClientId: '267557924375-jaoeb8t38vibf91aislr339i9fd6pec1.apps.googleusercontent.com',
    iosClientId: '267557924375-j7ilg4mhlqkpmuempu2kpddj5gmpmjoq.apps.googleusercontent.com',
    iosBundleId: 'com.elnooronline.alawael',
  );
}

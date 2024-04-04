import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCmFIqOMoStpgb18bE2yqojATNLpxvSit8",
            authDomain: "play-e84eb.firebaseapp.com",
            projectId: "play-e84eb",
            storageBucket: "play-e84eb.appspot.com",
            messagingSenderId: "22858644809",
            appId: "1:22858644809:web:218957a6e14fd78bd96e98",
            measurementId: "G-5EB22CNP93"));
  } else {
    await Firebase.initializeApp();
  }
}

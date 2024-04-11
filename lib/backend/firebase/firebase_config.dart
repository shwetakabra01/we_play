import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDdU6DUUS872Pz1IhmwY8oDHg5xMrso9UE",
            authDomain: "playprod-2b863.firebaseapp.com",
            projectId: "playprod-2b863",
            storageBucket: "playprod-2b863.appspot.com",
            messagingSenderId: "999117315504",
            appId: "1:999117315504:web:f62553e34d3aaf3ce30a75",
            measurementId: "G-RH21SP191H"));
  } else {
    await Firebase.initializeApp();
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDAnWsZ3-9ugexgJIpjjykgm0F8n8h-kR8",
            authDomain: "app-qolect.firebaseapp.com",
            projectId: "app-qolect",
            storageBucket: "app-qolect.firebasestorage.app",
            messagingSenderId: "784903621231",
            appId: "1:784903621231:web:325edb05d248d3ca6d1b9a",
            measurementId: "G-HRPMV103Y6"));
  } else {
    await Firebase.initializeApp();
  }
}

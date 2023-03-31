import 'package:firebase_app/view/screen/home_screen.dart';
import 'package:firebase_app/view/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBIxzwqDRXxXnMLZj9cwWWx-MPMr5SY3uQ",
        authDomain: "web-app-95d91.firebaseapp.com",
        projectId: "web-app-95d91",
        storageBucket: "web-app-95d91.appspot.com",
        messagingSenderId: "476107317725",
        appId: "1:476107317725:web:8d1590e5b6823967c11634"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:notebook_sqflite/screens/splash.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo Book',

      home: SplashScreen(),
    );
  }
}

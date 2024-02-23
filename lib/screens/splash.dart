import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notebook_sqflite/screens/home_screen.dart';
import 'package:notebook_sqflite/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: splashGradient,
        ),
        child: const Center(
          child: Text(
            'T O D O - B O O K',
            style: TextStyle(
                fontSize: 30,
                shadows: [
                  Shadow(
                    color: Colors.white70,
                    blurRadius: 2,
                  ),
                ],
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}

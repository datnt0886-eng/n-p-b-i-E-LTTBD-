import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UTH Todo',
      theme: ThemeData(
        primaryColor: const Color(0xFF3F5FEA),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Arial',
      ),
      home: const SplashScreen(),
    );
  }
}
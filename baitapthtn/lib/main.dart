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
      title: 'PRM393 Onboarding',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Cấu hình Màu sắc gốc từ bản thiết kế (Primary Purple)
        primaryColor: const Color(0xFF6200EE), 
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
    );
  }
}
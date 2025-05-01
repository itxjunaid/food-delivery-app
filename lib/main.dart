import 'package:flutter/material.dart';
import 'package:food_app/login_screen.dart';
import 'package:food_app/bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      // Start with LoginScreen, then navigate to MainScreen after login
      home: LoginScreen(),
      routes: {'/main': (context) => const MainScreen()},
    );
  }
}

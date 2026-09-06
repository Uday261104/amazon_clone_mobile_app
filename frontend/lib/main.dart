import 'package:flutter/material.dart';
import 'package:frontend/router.dart';
import 'package:frontend/view/home/homeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) => generateRoute(settings),
      debugShowCheckedModeBanner: false,
      title: 'Amazon Clone',
      home: const HomeScreen(),
    );
  }
}

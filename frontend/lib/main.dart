import 'package:flutter/material.dart';
import 'package:frontend/router.dart';
import 'package:frontend/view/auth/authScreen.dart';

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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Amazon'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Hello Amazon"),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Authscreen.routeName);
              },
              child: const Text("Click Me.."),
            ),
          ],
        ),
      ),
    );
  }
}

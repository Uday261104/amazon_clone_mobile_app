import 'package:flutter/material.dart';
import 'package:frontend/view/auth/authScreen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

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

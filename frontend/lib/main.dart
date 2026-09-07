import 'package:flutter/material.dart';
import 'package:frontend/controller/provider_controller/user_provider.dart';
import 'package:frontend/router.dart';
import 'package:provider/provider.dart';
import 'package:frontend/view/auth/authScreen.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazon Clone',
      initialRoute: Authscreen.routeName,
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
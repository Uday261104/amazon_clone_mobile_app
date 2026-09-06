import 'package:flutter/material.dart';
import 'package:frontend/view/auth/authScreen.dart';
import 'package:frontend/view/home/homeScreen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Authscreen.routeName:
      return MaterialPageRoute(builder: (_) => const Authscreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());

    default:
      return MaterialPageRoute(
        builder: (_) =>
            const Scaffold(body: Center(child: Text("PAGE NOT FOUND"))),
      );
  }
}

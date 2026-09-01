import 'package:flutter/material.dart';
import 'package:frontend/view/auth/authScreen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Authscreen.routeName:
      return MaterialPageRoute(builder: (_) => const Authscreen());

    default:
      return MaterialPageRoute(
        builder: (_) =>
            const Scaffold(body: Center(child: Text("PAGE NOT FOUND"))),
      );
  }
}

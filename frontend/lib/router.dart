import 'package:flutter/material.dart';
import 'package:frontend/view/auth/authScreen.dart';
import 'package:frontend/utils/bottom_nav_bar.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Authscreen.routeName:
      return MaterialPageRoute(builder: (_) => const Authscreen());

    case BottomNavBar.routeName:
      return MaterialPageRoute(builder: (_) => const BottomNavBar());

    default:
      return MaterialPageRoute(
        builder: (_) =>
            const Scaffold(body: Center(child: Text("PAGE NOT FOUND"))),
      );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/seller_view/add_product.dart';
import 'package:frontend/view/auth/auth_screen.dart';
import 'package:frontend/utils/bottom_nav_bar.dart';
import 'package:frontend/utils/seller_bottom_nav_bar.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Authscreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const Authscreen(),
      );

    case BottomNavBar.routeName:
      return MaterialPageRoute(
        builder: (_) => const BottomNavBar(),
      );

    case SellerBottomNavBar.routeName:
      return MaterialPageRoute(
        builder: (_) => const SellerBottomNavBar(),
      );

    case AddProductScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AddProductScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("PAGE NOT FOUND"),
          ),
        ),
      );
  }
}
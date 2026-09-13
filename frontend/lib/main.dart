import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend/controller/auth_controller.dart';
import 'package:frontend/controller/provider_controller/user_provider.dart';

import 'package:frontend/router.dart';
import 'package:frontend/view/auth/auth_screen.dart';
import 'package:frontend/utils/bottom_nav_bar.dart';
import 'package:frontend/utils/seller_bottom_nav_bar.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Authcontroller authController = Authcontroller();

  bool isLoading = true;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final userProvider =
        Provider.of<UserProvider>(context, listen: false);

    final token = await authController.fetchUserData(userProvider);

    if (!mounted) return;

    setState(() {
      isLoggedIn = token != null;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazon Clone',

      home: isLoading
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : isLoggedIn
              ? user.type == 'user'
                  ? const BottomNavBar()
                  : const SellerBottomNavBar()
              : const Authscreen(),

      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:frontend/controller/authController.dart';
import 'package:frontend/view/auth/authScreen.dart';

class SellerProductScreen extends StatelessWidget {
  const SellerProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Authcontroller().logOutUser();
              if (!context.mounted) return;
              Navigator.pushNamedAndRemoveUntil(
                context,
                Authscreen.routeName,
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Seller Product Screen'),
      ),
    );
  }
}
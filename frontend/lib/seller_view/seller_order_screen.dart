import 'package:flutter/material.dart';

import 'package:frontend/controller/authController.dart';

import 'package:frontend/view/auth/authScreen.dart';

import 'package:frontend/seller_view/addProduct.dart';

class SellerOrderScreen extends StatelessWidget {
  const SellerOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
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

      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AddProductScreen.routeName,
            );
          },
          child: const Text('Add Product'),
        ),
      ),
    );
  }
}
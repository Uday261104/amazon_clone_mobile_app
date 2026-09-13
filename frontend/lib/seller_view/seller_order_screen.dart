import 'package:flutter/material.dart';

import 'package:frontend/controller/auth_controller.dart';

import 'package:frontend/view/auth/auth_screen.dart';

import 'package:frontend/seller_view/add_product.dart';

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
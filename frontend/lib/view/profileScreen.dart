import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/controller/provider_controller/user_provider.dart';
import 'package:frontend/utils/account_button.dart';
import 'package:frontend/utils/singleProduct.dart';
import 'package:provider/provider.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF40B9F2),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: const Color(0xFF40B9F2),
            elevation: 0,
            title: Row(
              children: [
                SizedBox(
                  width: 90,
                  height: 40,
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),

                const Spacer(),

                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications),
                ),

                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
        ),

        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              child: Text(
                "Hello ${user.name} 👋",
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ProfileButton(
                    text: "My Orders",
                    onTap: () {},
                  ),
                  ProfileButton(
                    text: "My Wishlist",
                    onTap: () {},
                  ),
                  ProfileButton(
                    text: "Seller Mode",
                    onTap: () {},
                  ),
                  ProfileButton(
                    text: "Logout",
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "My Orders",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
   Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Singleproduct(
      imageUrl:
          "https://m.media-amazon.com/images/I/61RJn0ofUsL._SL1500_.jpg",
      productName: "Apple MacBook Pro",
      price: "₹1,29,900",
    ),

     const SizedBox(width: 30),

    Singleproduct(
      imageUrl:
          "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800",
      productName: "Smart Watch",
      price: "₹4,999",
    ),
  ],
),
  ],
),
          ],
        ),
      ),
    );
  }
}
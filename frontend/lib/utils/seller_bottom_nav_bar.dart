import 'package:flutter/material.dart';
import 'package:frontend/seller_view/seller_product_screen.dart';
import 'package:frontend/seller_view/seller_sales_screen.dart';
import 'package:frontend/seller_view/seller_order_screen.dart';
class SellerBottomNavBar extends StatefulWidget {
  static const String routeName = '/seller-bottom-nav-bar';

  const SellerBottomNavBar({super.key});

  @override
  State<SellerBottomNavBar> createState() => _SellerBottomNavBarState();
}

class _SellerBottomNavBarState extends State<SellerBottomNavBar> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const SellerProductScreen(),
    const SellerSalesScreen(),
    const SellerOrderScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                currentIndex: currentIndex,
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedItemColor: Colors.orange,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 12,
                unselectedFontSize: 12,

                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },

                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.inventory_2_rounded),
                    label: 'Products',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bar_chart_rounded),
                    label: 'Sales',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.local_shipping_rounded),
                    label: 'Orders',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
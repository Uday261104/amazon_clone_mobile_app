import 'package:flutter/material.dart';
import 'package:frontend/view/home_screen.dart';
import 'package:frontend/view/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  static const String routeName = '/';

  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  List<Widget> screens = [Homescreen(), Profilescreen()];

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
                  color: Colors.black.withValues(alpha: 0.05),
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

                // Removes the grey/black selected background
                selectedFontSize: 12,
                unselectedFontSize: 12,

                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },

                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
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

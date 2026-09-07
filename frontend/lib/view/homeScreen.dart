import 'package:flutter/material.dart';
import 'package:frontend/controller/provider_controller/user_provider.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  static const String routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Profile header
              const CircleAvatar(
                radius: 45,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                user.email,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 25),

              // User information card
              Card(
                elevation: 2,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _userInfo(
                        icon: Icons.badge_outlined,
                        title: 'User ID',
                        value: user.id,
                      ),

                      const Divider(height: 30),

                      _userInfo(
                        icon: Icons.email_outlined,
                        title: 'Email',
                        value: user.email,
                      ),

                      const Divider(height: 30),

                      _userInfo(
                        icon: Icons.lock_outline,
                        title: 'Password',
                        value: user.password,
                      ),

                      const Divider(height: 30),

                      _userInfo(
                        icon: Icons.location_on_outlined,
                        title: 'Address',
                        value: user.address.isEmpty
                            ? 'Not provided'
                            : user.address,
                      ),

                      const Divider(height: 30),

                      _userInfo(
                        icon: Icons.person_outline,
                        title: 'Account Type',
                        value: user.type,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userInfo({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 24,
          color: Colors.black87,
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
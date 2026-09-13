import 'package:flutter/material.dart';
import 'package:frontend/utils/bottom_nav_bar.dart';
import 'package:frontend/utils/seller_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../controller/auth_controller.dart';
import '../../controller/provider_controller/user_provider.dart';

class Authscreen extends StatefulWidget {
  static const String routeName = '/auth-screen';

  const Authscreen({super.key});

  @override
  State<Authscreen> createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
  final _signUpkey = GlobalKey<FormState>();
  final _signInkey = GlobalKey<FormState>();

  final Authcontroller authcontroller = Authcontroller();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String email = '';
  String password = '';

  bool isLoginEnabled = true;

  // =========================
  // SIGN UP
  // =========================
  void _submitSignUp() async {
    final isValid = _signUpkey.currentState!.validate();

    if (!isValid) {
      return;
    }

    final statusCode = await authcontroller.signUpUser(
      email: emailController.text.trim(),
      name: nameController.text.trim(),
      password: passwordController.text,
    );

    if (!mounted) {
      return;
    }

    if (statusCode == 201) {
      setState(() {
        isLoginEnabled = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created. Please sign in.')),
      );

      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Could not create account. Please try again.'),
      ),
    );
  }

  // =========================
  // SIGN IN
  // =========================
  void _submitSignIn() async {
    final isValid = _signInkey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _signInkey.currentState!.save();

    // Get UserProvider
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final statusCode = await authcontroller.signInUser(
      email: email,
      password: password,
      userProvider: userProvider,
    );

    if (!mounted) {
      return;
    }

    if (statusCode == 200) {
      final userType = userProvider.user.type;

      if (userType == 'seller') {
        Navigator.pushNamedAndRemoveUntil(
          context,
          SellerBottomNavBar.routeName,
          (route) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          BottomNavBar.routeName,
          (route) => false,
        );
      }

      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sign in failed. Check your email and password.'),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "Amazon Clone",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: isLoginEnabled ? _buildSignInForm() : _buildSignUpForm(),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SIGN IN FORM
  // ============================================================

  Widget _buildSignInForm() {
    return Form(
      key: _signInkey,
      child: Column(
        children: [
          const Text(
            "Sign in with your Email and Password.",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Sign In",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),

              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 40),
                ),
                child: const Text(
                  "Forget Password",
                  style: TextStyle(fontSize: 17, color: Colors.deepPurple),
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          // EMAIL
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Email",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 6),

          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,

            onSaved: (value) {
              email = value!.trim();
            },

            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Email is required";
              }

              final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');

              if (!emailRegex.hasMatch(value.trim())) {
                return "Enter a valid email address";
              }

              return null;
            },

            decoration: InputDecoration(
              hintText: "Enter your Email",
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.redAccent),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // PASSWORD
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Password",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 6),

          TextFormField(
            controller: passwordController,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,

            onSaved: (value) {
              password = value!;
            },

            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }

              return null;
            },

            decoration: InputDecoration(
              hintText: "Enter your Password",
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.redAccent),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // SHOW PASSWORD
          CheckboxListTile(
            value: true,
            onChanged: (value) {},
            dense: true,
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            controlAffinity: ListTileControlAffinity.trailing,
            title: const Text("Show Password", style: TextStyle(fontSize: 15)),
          ),

          // KEEP SIGN IN
          CheckboxListTile(
            value: true,
            onChanged: (value) {},
            dense: true,
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            controlAffinity: ListTileControlAffinity.trailing,
            title: const Text("Keep Sign In", style: TextStyle(fontSize: 15)),
          ),

          const SizedBox(height: 10),

          // SIGN IN BUTTON
          InkWell(
            onTap: _submitSignIn,
            child: Container(
              width: double.infinity,
              height: 54,
              decoration: const BoxDecoration(color: Colors.orange),
              child: const Center(
                child: Text("Sign In", style: TextStyle(fontSize: 15)),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Divider(thickness: 1),

          const SizedBox(height: 6),

          const Text("New to Amazon Clone", style: TextStyle(fontSize: 14)),

          const SizedBox(height: 15),

          // CREATE ACCOUNT
          InkWell(
            onTap: () {
              setState(() {
                isLoginEnabled = false;
              });
            },
            child: Container(
              width: double.infinity,
              height: 54,
              decoration: BoxDecoration(color: Colors.orange[200]),
              child: const Center(
                child: Text(
                  "Create a new Account",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: const Text(
              "Conditions of Use  Privacy Notice",
              style: TextStyle(color: Colors.deepPurple, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SIGN UP FORM
  // ============================================================

  Widget _buildSignUpForm() {
    return Form(
      key: _signUpkey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                "Create Account",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // NAME
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Your Name",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 6),

          TextFormField(
            controller: nameController,
            keyboardType: TextInputType.name,

            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Please enter your name";
              }

              return null;
            },

            decoration: InputDecoration(
              hintText: "Enter your Name",
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.redAccent),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // EMAIL
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Email",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 6),

          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,

            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Email is required";
              }

              final email = value.trim();

              final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');

              if (!emailRegex.hasMatch(email)) {
                return "Enter a valid email address";
              }

              return null;
            },

            decoration: InputDecoration(
              hintText: "Enter your Email",
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.redAccent),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // PASSWORD
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Password",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 6),

          TextFormField(
            controller: passwordController,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,

            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }

              final passwordRegex = RegExp(r'^.{4,}$');

              if (!passwordRegex.hasMatch(value)) {
                return "Password must be at least 4 characters";
              }

              return null;
            },

            decoration: InputDecoration(
              hintText: "Enter Password",
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.redAccent),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 5),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Password must be at least 4 characters"),
          ),

          const SizedBox(height: 10),

          // RE-ENTER PASSWORD
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Re-enter Password",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 6),

          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,

            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please re-enter your password";
              }

              if (value != passwordController.text) {
                return "Passwords do not match";
              }

              return null;
            },

            decoration: InputDecoration(
              hintText: "Re-enter your Password",
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.redAccent),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // CREATE ACCOUNT BUTTON
          InkWell(
            onTap: _submitSignUp,
            child: Container(
              width: double.infinity,
              height: 54,
              decoration: const BoxDecoration(color: Colors.orange),
              child: const Center(
                child: Text("Create Account", style: TextStyle(fontSize: 15)),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Divider(thickness: 1),

          const SizedBox(height: 6),

          const Text("Already a Customer", style: TextStyle(fontSize: 14)),

          const SizedBox(height: 15),

          // SIGN IN BUTTON
          InkWell(
            onTap: () {
              setState(() {
                isLoginEnabled = true;
              });
            },
            child: Container(
              width: double.infinity,
              height: 54,
              decoration: BoxDecoration(color: Colors.orange[200]),
              child: const Center(
                child: Text("Sign In", style: TextStyle(fontSize: 15)),
              ),
            ),
          ),

          const SizedBox(height: 20),

          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: const Text(
              "By creating account you agree Amazon Clone Conditions of Use and Privacy Notice",
              style: TextStyle(color: Colors.deepPurple, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

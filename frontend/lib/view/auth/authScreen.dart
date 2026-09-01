import 'package:flutter/material.dart';

class Authscreen extends StatefulWidget {
  static const String routeName = '/auth-screen';

  const Authscreen({super.key});

  @override
  State<Authscreen> createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
  final _signUpkey = GlobalKey<FormState>();
  final _signInkey = GlobalKey<FormState>();

  final passwordController = TextEditingController();

  bool isLoginEnabled = true;

  void _submitSignUp() {
    final isValid = _signUpkey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _signUpkey.currentState!.save();
  }

  void _submitSignIn() {
    final isValid = _signInkey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _signInkey.currentState!.save();
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
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 150,
              child: isLoginEnabled
                  ? Form(
                      key: _signInkey,
                      child: Column(
                        children: [
                          const Text(
                            "Sign in with your Email and Password.",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Sign In",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 40),
                                ),
                                child: const Text(
                                  "Forget Password",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          // Email
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Email is required";
                              }

                              final emailRegex = RegExp(
                                r'^[\w\.-]+@[\w\.-]+\.\w+$',
                              );

                              if (!emailRegex.hasMatch(value.trim())) {
                                return "Enter a valid email address";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Enter your Email",
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                ),
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

                          // Password
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Enter your Password",
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                ),
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

                          CheckboxListTile(
                            value: true,
                            onChanged: (value) {},
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: const Text(
                              "Show Password",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),

                          CheckboxListTile(
                            value: true,
                            onChanged: (value) {},
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: const Text(
                              "Keep Sign In",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),

                          const SizedBox(height: 10),

                          InkWell(
                            onTap: () {
                              _submitSignIn();
                            },
                            child: Container(
                              width: double.infinity,
                              height: 54,
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                              ),
                              child: const Center(
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          const Divider(thickness: 1),

                          const SizedBox(height: 6),

                          const Text(
                            "New to Amazon Clone",
                            style: TextStyle(fontSize: 14),
                          ),

                          const SizedBox(height: 15),

                          InkWell(
                            onTap: () {
                              setState(() {
                                isLoginEnabled = false;
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              height: 54,
                              decoration: BoxDecoration(
                                color: Colors.orange[200],
                              ),
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
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: const Text(
                              "Conditions of Use  Privacy Notice",
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Form(
                      key: _signUpkey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Create Account",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // Your Name
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Your Name",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          TextFormField(
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter your name";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Enter your Name",
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Email
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Email is required";
                              }

                              final email = value.trim();

                              final emailRegex = RegExp(
                                r'^[\w\.-]+@[\w\.-]+\.\w+$',
                              );

                              if (!emailRegex.hasMatch(email)) {
                                return "Enter a valid email address";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Enter your Email",
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Password
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              final passwordRegex = RegExp(
                                r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$',
                              );

                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              }

                              if (!passwordRegex.hasMatch(value)) {
                                return "Password must contain uppercase, lowercase, number and special character";
                              }

                              return null;
                            },

                            decoration: InputDecoration(
                              hintText: "Enter Password",
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Password must be at least 6 characters",
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Re-enter Password
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Re-enter Password",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          TextFormField(
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
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          InkWell(
                            onTap: () {
                              _submitSignUp();
                            },
                            child: Container(
                              width: double.infinity,
                              height: 54,
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                              ),
                              child: const Center(
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          const Divider(thickness: 1),

                          const SizedBox(height: 6),

                          const Text(
                            "Already a Customer",
                            style: TextStyle(fontSize: 14),
                          ),

                          const SizedBox(height: 15),

                          InkWell(
                            onTap: () {
                              setState(() {
                                isLoginEnabled = true;
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              height: 54,
                              decoration: BoxDecoration(
                                color: Colors.orange[200],
                              ),
                              child: const Center(
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          TextButton(
                            onPressed: () {
                              setState(() {
                                isLoginEnabled = true;
                              });
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: const Text(
                              "By createing account you agree Amazon Colne Conditions of Use and Privacy Notice",
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

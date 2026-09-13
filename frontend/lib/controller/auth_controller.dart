import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:frontend/controller/provider_controller/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/user_model.dart';
import '../constant/api_contants.dart';

class Authcontroller {
  Future<int?> signUpUser({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        email: email,
        name: name,
        password: password,
        address: '',
        type: 'user',
      );

      final response = await http.post(
        Uri.parse(ApiConstants.signUp),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": user.email,
          "name": user.name,
          "password": user.password,
        }),
      );

      debugPrint(response.statusCode.toString());
      debugPrint(response.body);

      return response.statusCode;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<int?> signInUser({
    required String email,
    required String password,
    required UserProvider userProvider,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.signIn),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      debugPrint(response.statusCode.toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        userProvider.setUser(data);

        final sharedPreferences = await SharedPreferences.getInstance();

        await sharedPreferences.setString("token", data['token']);
      }

      return response.statusCode;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<String?> fetchUserData(UserProvider userProvider) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();

      final token = sharedPreferences.getString("token");

      // No token → user is not logged in
      if (token == null) {
        return null;
      }

      // First validate the token
      final tokenRes = await http.post(
        Uri.parse(ApiConstants.validate),
        headers: {'Content-Type': 'application/json', 'token': token},
      );

      final response = jsonDecode(tokenRes.body);

      // Token is valid
      if (response == true) {
        final http.Response userRes = await http.get(
          Uri.parse(ApiConstants.user),
          headers: {'Content-Type': 'application/json', 'token': token},
        );

        if (userRes.statusCode == 200) {
          final userData = jsonDecode(userRes.body);

          userProvider.setUser(userData);
          return token;
        }
      }

      // Token is invalid
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> logOutUser() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.remove("token");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

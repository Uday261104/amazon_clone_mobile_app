import 'package:frontend/controller/provider_controller/user_provider.dart';

import '../model/userModel.dart';
import '../constant/api_contants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

      print(response.statusCode);
      print(response.body);

      return response.statusCode;
    } catch (e) {
      print(e);
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

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        userProvider.setUser(data);
      }

      return response.statusCode;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

import '../model/userModel.dart';
import '../constant/api_contants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Authcontroller {
  Future<void> signUpUser({
    required String email,
    required String name,
    required String password,
  }) async {
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
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toDB()),
    );

    print(response.body);
  }

  Future<void> signInUser({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(ApiConstants.signIn),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    print(response.body);
  }
}
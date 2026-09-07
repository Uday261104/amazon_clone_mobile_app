import 'dart:convert';

class User {
  final String id;
  final String email;
  final String name;
  final String password;
  final String address;
  final String type;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.address,
    required this.type,
  });

  factory User.fromDB(Map<String, dynamic> data) {
    return User(
      id: data['_id'],
      email: data['email'],
      name: data['name'],
      password: data['password'],
      address: data['address'],
      type: data['type'],
    );
  }

  Map<String, dynamic> toDB() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'password': password,
      'address': address,
      'type': type,
    };
  }

  factory User.fromJson(String source) {
    return User.fromDB(jsonDecode(source));
  }
}

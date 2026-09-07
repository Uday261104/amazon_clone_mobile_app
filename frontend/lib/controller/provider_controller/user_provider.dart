import 'package:flutter/foundation.dart';
import '../../model/userModel.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    email: '',
    name: '',
    password: '',
    address: '',
    type: '',
  );

  User get user => _user;

  void setUser(Map<String, dynamic> user) {
    _user = User.fromDB(user);

    notifyListeners();
  }
}

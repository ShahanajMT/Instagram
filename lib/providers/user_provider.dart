import 'package:flutter/material.dart';
import 'package:instagram_flutter/Models/resources/auth_methods.dart';

import '../Models/user_models.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethod _authMethod = AuthMethod(); 


  User? get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _authMethod.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
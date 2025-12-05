import 'package:flutter/material.dart';
import '../../data/repositories/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _repo = AuthRepository();

  bool isLoading = false;

  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    final success = await _repo.login(email, password);

    isLoading = false;
    notifyListeners();

    return success;
  }
}

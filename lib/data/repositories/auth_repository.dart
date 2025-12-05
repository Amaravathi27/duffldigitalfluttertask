class AuthRepository {
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // mimic API
    return true; // always success
  }
}

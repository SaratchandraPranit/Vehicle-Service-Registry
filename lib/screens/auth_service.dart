import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class AuthService {
  Future<bool> signUp(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    final user =
        ParseUser(email, password, email)
          ..set('name', name)
          ..set('phone', phone);
    var response = await user.signUp();
    return response.success;
  }

  Future<ParseUser?> login(String email, String password) async {
    final user = ParseUser(email, password, null);
    var response = await user.login();
    return response.success ? response.result : null;
  }

  Future<void> logout() async {
    final user = await ParseUser.currentUser();
    user?.logout();
  }
}

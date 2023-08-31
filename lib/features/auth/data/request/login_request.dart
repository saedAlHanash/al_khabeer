import 'package:al_khabeer/core/extensions/extensions.dart';
import 'package:al_khabeer/main.dart';

class LoginRequest {
  String username;
  String password;



  LoginRequest({
    this.username = '',
    this.password = '',
  });

  LoginRequest copyWith({
    String? phone,
    String? password,
  }) {
    return LoginRequest(
      username: phone ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}

// import 'dart:convert';
// import 'package:flutter_ecommerc/src/constant/token/token.dart';
// import 'package:flutter_ecommerc/src/data/model/login_response.dart';
// import 'package:flutter_ecommerc/src/data/model/user.dart';
// import 'package:flutter_ecommerc/src/data/provider/login_provider.dart';
// class LoginRepository {
//   LoginProvider loginProvider;
//   LoginRepository({required this.loginProvider});
//   Future<dynamic> login(Users user) async {
//     final response = await loginProvider.login(user);
//     if (response.statusCode == 200) {
//       final value = LoginResponse.fromJson(jsonDecode(response.body));
//       Token.setToken(value.token.toString());
//       return value;
//     }
//   }
// }

import 'package:flutter_ecommerc/src/data/model/login_response.dart';
import 'package:flutter_ecommerc/src/data/model/user.dart';
import 'package:flutter_ecommerc/src/data/provider/login_provider.dart';

class LoginRepository {
  LoginProvider loginProvider;
  LoginRepository({required this.loginProvider});
  Future<LoginResponse> login(Users user) async {
    return loginProvider.login(user);
  }
}

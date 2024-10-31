import 'dart:convert';
import 'package:flutter_ecommerc/src/constant/token/token.dart';
import 'package:flutter_ecommerc/src/constant/utils/url.dart';
import 'package:flutter_ecommerc/src/data/model/login_response.dart';
import 'package:flutter_ecommerc/src/data/model/user.dart';
import 'package:http/http.dart' as http;

class LoginProvider {
  Future<LoginResponse> login(Users user) async {
    print('user data:${user.email}');
    try {
      final response = await http.post(Uri.parse("${APPURL.BASEURL}/login"),
          headers: {
            "Content-Type": "application/json",
          },
          body:
              jsonEncode({"username": user.email, "password": user.password}));
      print("API URL: ${APPURL.BASEURL}/login");
      if (response.statusCode == 200) {
        final value = LoginResponse.fromJson(jsonDecode(response.body));
        Token.setToken(value.token.toString());
        print(value.token.toString());
        print("data:${response.body}");
        return value;
      }
      throw Exception(response.body);
    } catch (e, stacktrace) {
      print("Exception: $e");
      print("Stack trace: $stacktrace");
      throw Exception(e.toString());
    }
  }
}

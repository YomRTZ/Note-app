import 'package:shared_preferences/shared_preferences.dart';

class Token {
  // store the token at local storage
  // set token
  static Future<void> setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("auth_token", token);
  }

  // remove token
  static Future<void> removeToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("auth_token");
  }

  //get token
  static Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("auth_token");
  }
}

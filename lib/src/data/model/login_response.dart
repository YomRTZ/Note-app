class LoginResponse {
  final String token;
  final User user;
  LoginResponse({required this.token, required this.user});
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        token: json['token'], user: User.fromJson(json['user'] as Map<String, dynamic>),);
  }
}

class User {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? avater;
  User(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.avater});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json["email"],
        avater: json["avater"]);
  }
}

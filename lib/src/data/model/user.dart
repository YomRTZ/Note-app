class Users {
   String email;
   String password;
  Users({required this.email,required this.password});
  factory Users.fromJson(Map<String,dynamic>json){
    return Users(email: json['email'], password: json['password']);
  }
}
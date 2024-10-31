
import 'package:flutter_ecommerc/src/data/model/user.dart';

class AuthEvent {}
//like login button pressed 
class LoginEvent extends AuthEvent {
  Users user;
  LoginEvent({required this.user});
}
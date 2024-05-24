
import 'package:firebase_auth/firebase_auth.dart';



class auth_user{
  final bool is_user_verified;
  auth_user(this.is_user_verified);
  factory auth_user.fromFirebase(User user) => auth_user(user.emailVerified);


}
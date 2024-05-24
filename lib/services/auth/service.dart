import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes/services/auth/auth_provider.dart';
import 'package:notes/services/auth/auth_user.dart';
import 'package:notes/services/auth/auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/services/auth/firebase_auth_provider.dart';

class auth_services implements provider{

  final provider pro;

  const auth_services(this.pro);

  @override
  Future<void> SendEmailVerification() => pro.SendEmailVerification();

  @override
  Future<auth_user> create_user({required String password, required String email}) => pro.create_user(password: password, email: email);

  @override
  // TODO: implement current_user
  auth_user? get current_user => pro.current_user;

  @override
  Future<void> log_out() => pro.log_out();

  @override
  Future<auth_user> login({required String password, required String email}) =>pro.login(password: password, email: email);

}


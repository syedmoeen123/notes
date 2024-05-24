import 'package:flutter/cupertino.dart';
import 'package:notes/services/auth/auth_user.dart';

abstract class provider{

  auth_user? get current_user;


  Future<auth_user> login({required String password,
  required String email});

  Future<auth_user> create_user({
    required String password,
    required String email,
});

  Future<void> log_out();
  Future<void> SendEmailVerification();




}


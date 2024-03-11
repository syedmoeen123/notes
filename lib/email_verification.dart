import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Email_verification extends StatefulWidget {
  const Email_verification({super.key});

  @override
  State<Email_verification> createState() => _Email_verificationState();
}

class _Email_verificationState extends State<Email_verification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email verification'),
      ),
      body: TextButton(
        onPressed: (){
          final user= FirebaseAuth.instance.currentUser;
          user?.sendEmailVerification();
        },
        child: Text("send verification email"),
      ),

    );
  }
}
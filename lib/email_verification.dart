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
      body:

      Column(
        children:<Widget> [
          Text("we have sent you an email for verification "),
          Text("if you have not received the verification email click the button below"),
          TextButton(onPressed: (){
            var user=FirebaseAuth.instance.currentUser;
            user?.sendEmailVerification();
          }, child: Text("send email"),
          ),
          TextButton(onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil("/login/", (route) => false);

          }, child: Text("restart"))
        ],
      )

    );
  }
}
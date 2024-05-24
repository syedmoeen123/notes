import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/email_verification.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/views/Notes_view.dart';
import 'package:notes/views/login.dart';
import 'package:notes/views/register.dart';
import 'dart:developer'as dev_tool show log;


void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: Home_page(),
      routes: {"/login/":(context)=>const login_view(),
        "/register/":(context)=>const register_view(),
        "/notes/":(context)=>const Notes_view(),
        "/email_verification/":(context)=>const Email_verification(),
      },
    );
  }
}

class Home_page extends StatelessWidget {
  const Home_page({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:  Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,),
      builder:(context,snapshot){

        switch(snapshot.connectionState){
          case ConnectionState.done:
            final user= FirebaseAuth.instance.currentUser;
            if(user!=null){
              if(user.emailVerified){
                print('email verified');
              }else{
                return const Email_verification();
              }

            }else{
              return const login_view();
            }
            return const Notes_view();
          default:
            return Text("waiting");

        };

      }
      ,
    );

  }
}




import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/email_verification.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/views/login.dart';
import 'package:notes/views/register.dart';


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
      routes: {"/login/":(context)=>login_view(),
        "/register/":(context)=>register_view(),
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
            return Text("done");
          default:
            return Text("waiting");

        };

      }
      ,
    );

  }
}








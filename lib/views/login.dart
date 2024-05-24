import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/main.dart';
import 'dart:developer'as devtools show log;

class login_view extends StatefulWidget {
  const login_view({super.key});

  @override
  State<login_view> createState() => _login_viewState();
}

class _login_viewState extends State<login_view> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login view"),
      ),
      body: Column(

        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(controller:_email,
              decoration: InputDecoration(
                hintText: 'neverlosehope38@gmail.com',
                border: OutlineInputBorder(),
              ),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(controller: _password,
              decoration: InputDecoration(
                hintText: 'enter your password',
                border: OutlineInputBorder(),
              ),),
          ),
          TextButton(

            onPressed: () async{
              Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform
              );
              final email = _email.text;
              final password=_password.text;
              try{
                final credentials=await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password);
                final user=FirebaseAuth.instance.currentUser;
                if(user?.emailVerified??false){
                  Navigator.of(context).pushNamedAndRemoveUntil('/notes/', (route) => false);
                }
                else{
                  Navigator.of(context).pushNamedAndRemoveUntil('/email_verification/', (route) => false);
                }

              }on FirebaseAuthException catch(e){
                if(e.code=="INVALID_LOGIN_CREDENTIALS"){
                  showerrordialog(context, "INVALID_LOGIN_CREDENTIALS");
                }
                else{
                  showerrordialog(context, "error: ${e.code}");
                }

              }catch(e){
                showerrordialog(context, e.toString(),);
              }


            },
            child: Text('Login'),
          ),
          TextButton(onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil('/register/', (route) => false);

          },
              child: Text("not registered yet ,register here"))

        ],
      ),
    );
  }
}
Future<void> showerrordialog(BuildContext context,String text){
  return  showDialog(context: context, builder: (context){
    return AlertDialog(
      title: const Text("An error occured"),
      content: Text(text),
      actions: [
        TextButton(onPressed: (){}, child: const Text("OK"))
      ],
    );
  });
}

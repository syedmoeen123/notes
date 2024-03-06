import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/firebase_options.dart';

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

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("login screen"),
      ),
      body: FutureBuilder(
        future:  Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,),
        builder:(context,snapshot){
          return Center(
            child: Column(

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
                    }on FirebaseAuthException catch(e){
                   if(e.code=="INVALID_LOGIN_CREDENTIALS"){
                     print("INVALID_LOGIN_CREDENTIALS");
                   }
                   else{
                     print(e.code);
                   }

                    }


                  },
                  child: Text('Login'),
                )
              ],
            ),
          );
        }
        ,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/firebase_options.dart';

class register_view extends StatefulWidget {
  const register_view({super.key,});





  @override
  State<register_view> createState() => _register_viewState();
}

class _register_viewState extends State<register_view> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("registration screen"),
      ),
      body: FutureBuilder(
        future:  Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,),
        builder:(context,snapshot){
          return Column(

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
                    final credentials=await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email,
                        password: password);
                  }on FirebaseAuthException catch(e){
                   if(e.code=="email-already-in-use"){
                     print("email already taken");
                   }
                   else if(e.code=="invalid-email"){
                     print("invalid-email");
                   }
                   else{
                     print(e.code);
                   }
                  }


                },
                child: Text('Register'),
              )
            ],
          );
        }
        ,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}





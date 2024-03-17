import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer'as dev_tool show log;
import '../main.dart';

enum action_menu { log_out ,log_in}


class Notes_view extends StatefulWidget {
  const Notes_view({super.key});

  @override
  State<Notes_view> createState() => _Notes_viewState();
}

class _Notes_viewState extends State<Notes_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('main ui'),
        actions: [
          PopupMenuButton(onSelected: (value)async{
            final condition=await show_dialog_box(context);
            dev_tool.log(condition.toString());
            if(condition){
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil("/login/", (_) => false);
            }
          },
            itemBuilder: (context)
            {
              return const [
                PopupMenuItem<action_menu>(
                  value: action_menu.log_out,
                  child: Text('log_out'),
                ),

                PopupMenuItem<action_menu>(
                  value: action_menu.log_in,
                  child: Text('log_in',

                    style:TextStyle(
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.amberAccent

                    ) ,),
                )
              ];


            },)
        ],


      ),

    );
  }
}



Future<bool> show_dialog_box(BuildContext context){

  return showDialog(context: context,
      builder: (context){
        return AlertDialog(
          title:Text("sign_out"),
          content: Text("are you sure you want to log out"),
          actions: [
            TextButton(onPressed: (){Navigator.of(context).pop(true);}, child: Text("log_out")),
            TextButton(onPressed: (){Navigator.of(context).pop(false);}, child: Text("cancel")),

          ],
        );
      }
  ).then((value) => value ?? false);
}


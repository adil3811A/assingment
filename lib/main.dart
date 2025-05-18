import 'package:assingment/Screens/HomeScreen.dart';
import 'package:assingment/Screens/MainApp.dart';
import 'package:assingment/Screens/auth/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:FutureBuilder(
        future:  Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform
        ),
        builder: (context, snapshot
            ) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return Center(
                child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            // check is user login or not
            if(FirebaseAuth.instance.currentUser==null){
              return Registerscreen();
            }else{
              return Mainapp();
            }
          default:
            return Center(
             child:  Text('Default')
            );
        }
      },),
    );
  }
}


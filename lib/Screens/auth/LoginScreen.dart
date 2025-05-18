import 'package:assingment/Screens/MainApp.dart';
import 'package:assingment/Services/FirebaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ForgotPasswordScreen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final authfirebaseService = FirebaseService.FirebaseServiceControctor();
  late TextEditingController emailTextEdtitingController;
  late TextEditingController passwordTextEdtitingController;

  @override
  void initState() {
    super.initState();
    emailTextEdtitingController= TextEditingController();
    passwordTextEdtitingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          spacing: 24,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller:emailTextEdtitingController,
              decoration: InputDecoration(
                  label: Text('Enter Email')
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordTextEdtitingController,
              decoration: InputDecoration(
                  label: Text('Enter Password')
              ),
              keyboardType: TextInputType.visiblePassword,
            ),
            ElevatedButton(onPressed:() async{
              try{
                final user =await authfirebaseService.loginUser(
                    emailTextEdtitingController.text.toString(),
                    passwordTextEdtitingController.text.toString()
                );
                if(user!=null){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Mainapp()),(route) => false,);
                }
              }on FirebaseAuthException catch(e){
                switch(e.code){
                  case 'invalid-credential':
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Credential is Invalid'), duration: Duration(seconds: 3),));
                }
              }catch(e){
                print(e);
              }

            }, child: Text('Login')),
            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Forgotpasswordscreen(),));
            }, child: Text('Forgot password'))
          ],
        ),
      ),
    );
  }
}

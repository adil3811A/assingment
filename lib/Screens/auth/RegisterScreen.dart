import 'package:assingment/Screens/MainApp.dart';
import 'package:assingment/Screens/auth/LoginScreen.dart';
import 'package:assingment/Services/FirebaseService.dart';
import 'package:assingment/model/UserModule.dart';
import 'package:flutter/material.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {

  final authFireabseService = FirebaseService.FirebaseServiceControctor();
  late TextEditingController emailTextEditingController;
  late TextEditingController passwordTextEditingController;
  late TextEditingController phoneNumberTextEditingContoller;
  late TextEditingController nameTextEditingContoller;

  @override
  void initState() {
    emailTextEditingController = TextEditingController();
    passwordTextEditingController = TextEditingController();
    phoneNumberTextEditingContoller = TextEditingController();
    nameTextEditingContoller = TextEditingController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 24,
          children: [
            TextField(
              controller: emailTextEditingController,
              decoration: InputDecoration(
                label: Text('Enter Email')
              ),
            ),
            TextField(
              controller: passwordTextEditingController,
              decoration: InputDecoration(
                label: Text('Enter Password')
              ),
              keyboardType: TextInputType.visiblePassword,
            ),
            TextField(
              controller: phoneNumberTextEditingContoller,
              decoration: InputDecoration(
                label: Text('Enter Phone Number')
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: nameTextEditingContoller,
              decoration: InputDecoration(
                  label: Text('Enter Name')
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(onPressed:() async {
              final user = await authFireabseService.createUser(
                UserModule(
                    name: nameTextEditingContoller.text.toString(),
                    phone: phoneNumberTextEditingContoller.text.toString(),
                    email: emailTextEditingController.text.toString(),
                    imageurl: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                  password: passwordTextEditingController.text.toString()
                )
              );
              if(user!=null){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Mainapp(),), (route) => false,);
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Something went Wrong'), duration: Duration(seconds: 2),)
                );
              }
            }, child: Text('Register')),
            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Loginscreen(),));
            }, child: Text('Login if You already have account'))
          ],
        ),
      ),
    );
  }
}

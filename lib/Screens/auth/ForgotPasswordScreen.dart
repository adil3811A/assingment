import 'package:assingment/Screens/auth/ValidateOTP.dart';
import 'package:flutter/material.dart';

class Forgotpasswordscreen extends StatefulWidget {
  const Forgotpasswordscreen({super.key});

  @override
  State<Forgotpasswordscreen> createState() => _ForgotpasswordscreenState();
}

class _ForgotpasswordscreenState extends State<Forgotpasswordscreen> {
  late TextEditingController emailTextEditingController;

  @override
  void initState() {
    emailTextEditingController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    emailTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            spacing: 24,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailTextEditingController,
                decoration: InputDecoration(
                  label: Text('Enter your email')
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              ElevatedButton(onPressed: () {
                if(emailTextEditingController.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please Enter the email'), duration: Duration(seconds: 3),)
                  );
                }else{
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Validateotp(),));
                }
              }, child: Text('Send OTP'))
            ],
          ),
        ),
      ),
    );
  }
}

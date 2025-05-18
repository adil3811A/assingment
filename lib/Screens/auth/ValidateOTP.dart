import 'package:assingment/Screens/MainApp.dart';
import 'package:flutter/material.dart';

class Validateotp extends StatefulWidget {
  const Validateotp({super.key});

  @override
  State<Validateotp> createState() => _ValidateotpState();
}

class _ValidateotpState extends State<Validateotp> {

  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validate OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              maxLength: 4,
              controller: textEditingController,
              decoration: InputDecoration(
                label: Text('Enter OTP')
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(onPressed: () {
              if(textEditingController.text.toString().length<4){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('OTP is too short'), duration: Duration(seconds: 3),)
                );
                if(textEditingController.text!='1234'){
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('OTP is not valid'), duration: Duration(seconds: 3),)
                  );
                }
                Navigator.push(context, MaterialPageRoute(builder: (context) => Mainapp(),));
              }
            }, child: Text('Submit OTP')),
            Text('Note You can enter dummy OTP "1234"')
          ],
        ),
      ),
    );
  }
}
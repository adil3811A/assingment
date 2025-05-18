import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:assingment/Services/FirebaseService.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final firebaseService = FirebaseService.FirebaseServiceControctor();
  File? _selectedImage = null;
  final ImagePicker _picker = ImagePicker();
  late TextEditingController emailTextEditingController;

  late TextEditingController phoneTextEditingController;

  late TextEditingController nameTextEditingController;

  @override
  void initState() {
    emailTextEditingController = TextEditingController();
    phoneTextEditingController = TextEditingController();
    nameTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: firebaseService.getUserDetail(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              var user = snapshot.data;
              Widget _buildImage() {
                Widget imageWidget;

                if (_selectedImage != null) {
                  if (kIsWeb) {
                    imageWidget = Image.network(
                      _selectedImage!.path,
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    );
                  } else {
                    imageWidget = Image.file(
                      File(_selectedImage!.path),
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    );
                  }
                } else {
                  imageWidget = Image.network(
                    user!.imageurl,
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                  );
                }

                return ClipOval(
                  child: imageWidget,
                );
              }
              emailTextEditingController.text = user!.email;
              phoneTextEditingController.text = user.phone;
              nameTextEditingController.text = user.name;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: _pickImage,
                    child: _buildImage(),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: phoneTextEditingController,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: nameTextEditingController,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            // Cancel action
                          },
                          child: Text('Cancel'),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () async {
                            await firebaseService.uploadUserDataWithImage(
                                imageFile: _selectedImage,
                                email: emailTextEditingController.text.toString(),
                                phone: phoneTextEditingController.text.toString(),
                                password: user.password,
                                name: nameTextEditingController.text.toString()
                            );
                            print('Profile update');
                          },
                          child: Text('Update Profile'),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            default:
              return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85, // Optional: compress the image
    );
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }
}

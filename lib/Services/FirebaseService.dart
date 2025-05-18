import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:assingment/model/UserModule.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path/path.dart' as path;

class FirebaseService{


  // this code for Service Singleton
  static final FirebaseService _authFireabseService = FirebaseService._internal();
  factory FirebaseService.FirebaseServiceControctor(){
    return _authFireabseService;
  }
  FirebaseService._internal();

  Future<User?> createUser(UserModule userModule) async {
    try{
      final credential =await FirebaseAuth.instance.createUserWithEmailAndPassword(email:userModule.email, password: userModule.password);
      final userid = credential.user?.uid;
      final ref = FirebaseDatabase.instance.ref('user');
      await ref.child(userid!).set(userModule.toMap());

      return credential.user;
    }catch (e){
      return null;
    }

  }

  Future<User?> loginUser(String email , String password)async{
    final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }
  Future<UserModule> getUserDetail()async{
    final userid = FirebaseAuth.instance.currentUser!.uid;
    final responce =await FirebaseDatabase.instance.ref('user/$userid').get();
    if (responce.exists) {
      final data = Map<String, dynamic>.from(responce.value as Map);
      return UserModule.fromJson(data);
    } else {
      throw Exception('User not found');
    }
  }

  Future<void> uploadUserDataWithImage({
    required File? imageFile,
    required String email,
    required String phone,
    required String password,
    required String name,
  }) async {
    String imageUrl = 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
    //1 .get uid
    String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      if (imageFile == null){
        DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child('user').child(uid);
        await userRef.update({
          'email': email,
          'password': password,
          'phone':phone,
          'name': name,
          'imageUrl': imageUrl,
        });
      }else{
        // 2. Get file extension
        String extension = path.extension(imageFile.path); // e.g. .jpg, .png
        print('file extension is $extension');
        // 3. Upload image to Firebase Storage with correct extension
        String fileName = 'profile_images/$uid$extension';
        Reference ref = FirebaseStorage.instance.ref().child(fileName);
        UploadTask uploadTask = ref.putFile(imageFile);
        TaskSnapshot snapshot = await uploadTask;
        String downloadURL = await snapshot.ref.getDownloadURL();

        // 4. Save user data in Realtime Database
        DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child('user').child(uid);
        await userRef.update({
          'email': email,
          'password': password,
          'phone':phone,
          'name': name,
          'imageUrl': downloadURL,
        });
        print('User registered and data uploaded successfully.');
      }
      }catch(e){
      print(e);
    }
  }
}
class UserModule{
  final String name;
  final String phone;
  final String email;
  final String imageurl;
  final String password;
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email' : email,
      'imageUrl': imageurl,
      'password' : password
    };
  }
  factory UserModule.fromJson(Map<String, dynamic> json) {
    return UserModule(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      imageurl: json['imageUrl'] ?? '',
      phone: json['phone']??'',
      password: json['password']??''
    );
  }
  const UserModule({required this.name, required this.phone, required this.email, required this.imageurl, required this.password});
}
import 'package:assingment/Screens/HomeScreen.dart';
import 'ProfileScreen.dart';
import 'package:flutter/material.dart';

class Mainapp extends StatefulWidget {
  const Mainapp({super.key});
  @override
  State<Mainapp> createState() => _MainappState();
}
const screens = [
  Homescreen(),
  ProfileScreen()
];
class _MainappState extends State<Mainapp> {
  int index = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() {
            index=  value;
          });
        },
          destinations: [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.person), label: 'profile'),
      ]),
      body: screens[index],
      
    );
  }
}

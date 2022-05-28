import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home_screen.dart';
import 'package:flutter_firebase/screens/login_screen.dart';
import 'package:hive/hive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("I am not logged in");
      //navigate to login screen;
      Future.delayed(
        Duration(seconds: 2),
        () async {
          await Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) {
            return LoginScreen();
          }), (route) => false);
        },
      );
    } else {
      print("I am  logged in");

      //navigate to home screen
      //navigate to login screen;
      Future.delayed(
        Duration(seconds: 2),
        () async {
          await Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) {
            return HomeScreen();
          }), (route) => false);
        },
      );
    }
  }

  openBoxes() async {
    try {
      Box testBox = await Hive.openBox('testBox');

      if (testBox.isOpen) {
        print(testBox.path);
        print("Box has been opened");
      } else {
        print("Box not open");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openBoxes();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
    );
  }
}

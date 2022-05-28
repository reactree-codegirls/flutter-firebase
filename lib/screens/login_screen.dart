import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/models.dart';
import 'package:flutter_firebase/screens/home_screen.dart';
import 'package:flutter_firebase/services/db.dart';
import 'package:flutter_firebase/services/hive_service.dart';
import 'package:flutter_firebase/services/shared_preference_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future loginUser() async {
    try {
      var usercredentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      if (usercredentials.user != null) {
        print(usercredentials.user!.uid);
        UserModel? userModel =
            await DbService().getUser(usercredentials.user!.uid);
        await Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) {
          return HomeScreen(
            userModel: userModel,
          );
        }), (route) => false);
      } else {
        print("No User FOund");
      }
    } catch (e) {
      print("ErrorFound");
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                controller: emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                controller: passwordController,
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  // SharedPreferenceService().setData("Ali");
                  UserModel userModel = UserModel(
                      age: 20,
                      fatherName: "Ali",
                      name: "Ahmed",
                      studentId: "123456");
                  HiveService().setData(userModel);
                },
                child: Text("Set Data")),
            ElevatedButton(
                onPressed: () async {
                  // SharedPreferenceService().getData();
                  HiveService().getData();
                },
                child: Text("Get Data")),
            ElevatedButton(
                onPressed: () async {
                  loginUser();
                },
                child: Text("Login")),
            ElevatedButton(
                onPressed: () async {
                  HiveService().looping();
                },
                child: Text("Debug example"))
          ],
        ),
      )),
    );
  }
}

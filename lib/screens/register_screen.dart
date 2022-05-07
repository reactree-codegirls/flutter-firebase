import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/db.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  Future registerUser() async {
    try {
      UserCredential usercredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      if (usercredentials.user != null) {
        print(usercredentials.user!.uid);
        DbService().createDocument(
            nameController.text,
            fatherNameController.text,
            int.parse(ageController.text),
            usercredentials.user!.uid);
      } else {
        print("No User FOund");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 15),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: "Name",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.grey.shade500,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.blue.shade300,
                        ))),
              ),
            ),
            TextFormField(
              controller: fatherNameController,
              decoration: InputDecoration(
                  hintText: "Father's Name",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade500,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.blue.shade300,
                      ))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Age",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade500,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.blue.shade300,
                      ))),
            ),
            ElevatedButton(
                onPressed: () {
                  registerUser();
                },
                child: Text("Register"))
          ],
        ),
      )),
    );
  }
}

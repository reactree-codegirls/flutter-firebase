import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/models.dart';
import 'package:flutter_firebase/screens/futureBuilderWidget.dart';
import 'package:flutter_firebase/screens/login_screen.dart';
import 'package:flutter_firebase/screens/register_screen.dart';
import 'package:flutter_firebase/screens/streamBuilderWidget.dart';
import 'package:flutter_firebase/screens/uploadImageScreen.dart';

class HomeScreen extends StatefulWidget {
  UserModel? userModel;
  HomeScreen({this.userModel});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  List<UserModel> allUsers = [];

  initState() {
    configureFCM();
    super.initState();
  }

  configureFCM() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      print(token);

      FirebaseMessaging.onBackgroundMessage((message) async {
        
      });

      FirebaseMessaging.onMessage.listen((event) { 
        
      });
    } catch (e) {}
  }

  Future createDocument() async {
    var queryDoc = FirebaseFirestore.instance.collection("students").doc();
    try {
      await queryDoc.set({
        "name": nameController.text,
        "fatherName": fatherNameController.text,
        "age": int.parse(ageController.text),
        "studentId": queryDoc.id
      });
    } catch (e) {
      print(e);
    }
  }

  Future getSingleDocument() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection("students")
              .doc("r2myePWzL12O8RUT7QTh")
              .get();
      print(documentSnapshot.data());
      UserModel userModel = UserModel.fromJson(documentSnapshot.data()!);
      print(userModel.name);
    } catch (e) {
      print(e);
    }
  }

  Future getManyDocuments() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("students")
        // .where("age", isGreaterThan: 25)
        .get();
    List<UserModel> _allUsers = [];

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      print(querySnapshot.docs[i].data());
      UserModel userModel = UserModel.fromJson(querySnapshot.docs[i].data());

      _allUsers.add(userModel);
    }
    print(_allUsers);
    setState(() {
      allUsers.addAll(_allUsers);
    });
  }

  Future deleteUser(String studentId) async {
    await FirebaseFirestore.instance
        .collection("students")
        .doc(studentId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  await Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (_) {
                    return LoginScreen();
                  }), (route) => false);
                } catch (e) {}
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.userModel != null
                ? Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "User Details",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(widget.userModel!.name),
                          Text(widget.userModel!.fatherName),
                          Text(widget.userModel!.age.toString()),
                          Text(widget.userModel!.studentId),
                        ],
                      ),
                    ),
                  )
                : Container(),
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
            ElevatedButton(onPressed: createDocument, child: Text("Submit")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => RegisterScreen()));
                },
                child: Text("Register")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                },
                child: Text("LOGIN")),
            ElevatedButton(
                onPressed: getManyDocuments, child: Text("Get All Documents")),
            ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => UploadImageScreen())),
                child: Text("Upload image")),
            ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => FutureBuilderWidget())),
                child: Text("Future Builder")),
            ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => StreamBuilderWidget())),
                child: Text("Stream Builder")),
            ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: allUsers.length,
                itemBuilder: (_, i) {
                  return ListTile(
                    title: Column(
                      children: [
                        Text("Name: ${allUsers[i].name}"),
                        Text("StudentId: ${allUsers[i].studentId}"),
                      ],
                    ),
                    subtitle: Text("Age: ${allUsers[i].age}"),
                    trailing: IconButton(
                        onPressed: () {
                          deleteUser(allUsers[i].studentId);
                          // allUsers.removeWhere((UserModel user) => user.studentId==allUsers[i].studentId);
                          setState(() {
                            allUsers.removeAt(i);
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  );
                })
          ],
        ),
      ),
    );
  }
}

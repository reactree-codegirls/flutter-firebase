import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/models.dart';

class DbService {
  Future createDocument(
      String name, String fatherName, int age, String studentId) async {
    var queryDoc =
        FirebaseFirestore.instance.collection("students").doc(studentId);
    try {
      await queryDoc.set({
        "name": name,
        "fatherName": fatherName,
        "age": age,
        "studentId": studentId
      });
      print("User Record Created Succesfully");
    } catch (e) {
      print(e);
    }
  }

  Future<UserModel?> getUser(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection("students")
              .doc(uid)
              .get();
      print(documentSnapshot.data());
      UserModel userModel = UserModel.fromJson(documentSnapshot.data()!);
      print(userModel.name);
      return userModel;
    } catch (e) {
      print(e);
    }
  }
}

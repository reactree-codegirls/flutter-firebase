import 'package:flutter_firebase/models/models.dart';
import 'package:hive_flutter/adapters.dart';

class HiveService {
  String hello = "Hello world";

  setData(UserModel user) async {
    try {
      var box = Hive.box('testBox');
      await box.put("user", user);
      // await box.put('name', user.name);

      // await box.put('friends', ['Dave', 'Simon', 'Lisa']);

      // await box.put(123, 'test');

      // await box.putAll({'key1': 'value1', 42: 'life'});
      print("Succesfull");
    } catch (e) {
      print(e.toString());
    }
  }

  getData() {
    var box = Hive.box('testBox');

    // String name = box.get('name');
    // print("name: $name");
    UserModel user = box.get("user");
    print(user.name);
    print(user);
  }

  looping() {
    List<String> students = ["Ali", "ahmed", "sarah"];
    for (var i = 0; i < students.length; i++) {
      print(students[i]);
    }
  }
}

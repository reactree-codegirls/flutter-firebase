import 'package:hive/hive.dart';
part 'models.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String fatherName;
  @HiveField(2)
  String studentId;
  @HiveField(3)
  int age;
  UserModel(
      {this.age = 0,
      this.name = "",
      this.fatherName = "",
      this.studentId = ""});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        age: json["age"],
        name: json["name"],
        fatherName: json["fatherName"],
        studentId: json["studentId"]);
  }

  toJson() {
    return {
      "age": age,
      "name": name,
      "fatherName": fatherName,
      "studentId": studentId
    };
  }
}

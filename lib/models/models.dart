class UserModel {
  String name, fatherName, studentId;
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

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  setData(String name) async {
    final sharedPefInstance = await SharedPreferences.getInstance();
    sharedPefInstance.setString("myName", name);
  }

  getData() async {
    final sharedPefInstance = await SharedPreferences.getInstance();
    String myName = sharedPefInstance.get("myName") as String;
    print("My name is $myName in the shared preferences");
  }
}

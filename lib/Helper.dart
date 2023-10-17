import 'package:shared_preferences/shared_preferences.dart';
class Helper {
  static String valueSharedPreferences = 'salary';
  static Future<bool> setSalary(value) async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(valueSharedPreferences, value);
  }
}

import 'package:shared_preferences/shared_preferences.dart';
/*
  Future<LoginEntity> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var u = prefs.getString(
      PrefConstant.USER,
    );
    if (u != null) return LoginEntity.fromJson(await json.decode(u));
  }

  Future<bool> clearPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
  Future<bool> saveUser(LoginEntity userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(PrefConstant.USER, json.encode(userData.toJson()));
  }
*/

  Future<bool> setPrefrenceData({dynamic data, required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (data is bool)
      return prefs.setBool(key, data);
    else if (data is String)
      return prefs.setString(key, data);
    else if (data is int)
      return prefs.setInt(key, data);
    else
      return false;
  }

  Future<dynamic> getPrefrenceData({dynamic defaultValue, required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (defaultValue is bool)
      return prefs.getBool(key);
    else if (defaultValue is String)
      return prefs.getString(key);
    else if (defaultValue is int)
      return prefs.getInt(key);
    else
      return false;
}
Future<bool> removPrefrenceData({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.remove(key);
}

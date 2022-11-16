import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{
  final SharedPreferences sharedPreferences;
  SharedPreferenceHelper({required this.sharedPreferences});

  String? getData({required String key}) {
    var getData = sharedPreferences.getString(key);
    return getData;
  }

  Future<bool> setData({required String key, required String value}) async {
    var setData = await sharedPreferences.setString(key, value);
    return setData;
  }

  Future<bool> deleteData({required String key}) async {
    var deletedData = await sharedPreferences.remove(key);
    return deletedData;
  }

}
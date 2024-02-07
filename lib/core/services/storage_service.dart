import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _pref;

  static Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static Future setFirstOpen(bool firstOpen) async {
    await _pref.setBool('first_open', firstOpen);
  }

  static bool getFirstOpen() {
    return _pref.getBool('first_open') ?? false;
  }
}

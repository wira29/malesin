import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static PreferencesHelper? _instance;
  SharedPreferences? prefs;

  PreferencesHelper._internal() {
    _instance = this;
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  factory PreferencesHelper() => _instance ?? PreferencesHelper._internal();

  Future<void> writePreferencesBool(String action, bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(action, value);
  }

  bool readPreferencesBool(String action) {
    return prefs?.getBool(action) ?? false;
  }
}



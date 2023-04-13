import 'package:shared_preferences/shared_preferences.dart';

///Usage:
/// - initialize the Helper to create an instance for SharedPreferences: [SharedPreferenceHelper.instance.init()];
class SharedPreferenceHelper {
  SharedPreferenceHelper._internal();
  static final SharedPreferenceHelper _spSingleton =
      SharedPreferenceHelper._internal();

  static SharedPreferenceHelper get instance => _spSingleton;

  /// Needs to run SharedPreferenceHelper.instance.init() before.
  /// Made private to close modifications
  static late SharedPreferences _sharedPrefInstance;
  void init() {
   SharedPreferences.getInstance()
        .then((value) => _sharedPrefInstance = value);
  }


  static bool get hasAppRan => _sharedPrefInstance.getBool(PreferencesKey.hasAppRanKey) ?? false;
  static set hasAppRan(bool? hasAppRan) {
    _sharedPrefInstance.setBool(PreferencesKey.hasAppRanKey, hasAppRan!);
  }

  /// Save User login data for feature use
  // static Future<bool> saveUser(LoginData? data) async {
  //   if (data != null) {
  //     return _sharedPrefInstance.setString(PreferencesKey.userKey, json.encode(data.toJson()));
  //   } else {
  //     return deletePreferences(PreferencesKey.userKey);
  //   }
  // }
  /// Get User
  // static Future<LoginData?> getUser() async {
  //   late LoginData user;
  //   if (_sharedPrefInstance.getString(PreferencesKey.userKey) != null) {
  //     user = LoginData.fromJson(json.decode(_sharedPrefInstance.getString(PreferencesKey.userKey)!));
  //   }
  //   return user;
  // }
  // /// to delete the preference
  // static Future<bool> deletePreferences(String key) async {
  //   return _sharedPrefInstance.remove(key);
  // }
}
class PreferencesKey {
  ///User login key to save user login data
  static String userKey = 'user';
  ///a key to check if it's app has ran before. Will be true if app has ran before.
  static String hasAppRanKey = 'hasAppRan';

}

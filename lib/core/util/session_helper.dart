import 'package:shared_preferences/shared_preferences.dart';
import '../core.dart';

abstract class Session {
  set setIndexLanguage(int index);

  int get isIndex;
  String get isToken;
}

class SessionHelper implements Session {
  final SharedPreferences pref;

  SessionHelper({required this.pref});
  @override
  set setIndexLanguage(int index) {
    pref.setInt(IS_INDEX, index);
  }

  @override
  set setToken(String token) {
    pref.setString(SESSION_TOKEN, token);
  }

  @override
  int get isIndex => pref.getInt(IS_INDEX) ?? 0;
  @override
  String get isToken => pref.getString(SESSION_TOKEN) ?? '';
}

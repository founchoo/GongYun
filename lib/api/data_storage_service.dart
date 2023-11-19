import 'package:shared_preferences/shared_preferences.dart';

class DataStorage {

  static SharedPreferences? prefs;

  static const keyCookie = 'cookie';

  static const keyStudentId = 'studentId';
  static const defaultValueStudentId = '';
  static const keyPassword = 'password';
  static const defaultValuePassword = '';
  static const keyEnrollYear = 'enrollYear';
  static const defaultValueEnrollYear = '';

  static const keyIsShowNonCurrentWeek = 'showNonCurrentWeek';
  static const defaultValueIsShowNonCurrentWeek = false;
  static const keyIsShowYear = 'showYear';
  static const defaultValueIsShowYear = false;
  static const keyIsShowDate = 'showDate';
  static const defaultValueIsShowDate = false;
  static const keyIsShowTime = 'showTime';
  static const defaultValueIsShowTime = false;
  static const keyIsShowDesktopShortcut = 'showDesktopShortcut';
  static const defaultValueIsShowDesktopShortcut = false;
  static const keyDarkMode = 'darkMode';
  static const defaultValueDarkMode = '跟随系统';
  static const keyIsSysColor = 'sysColor';
  static const defaultValueIsSysColor = false;

  /// 初始化 SharedPreferences
  static Future<void> initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
}

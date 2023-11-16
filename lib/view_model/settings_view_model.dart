import 'package:gong_yun/api/chaoxing_service.dart';
import 'package:gong_yun/api/data_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';

class SettingsViewModel extends ViewModel {
  bool isLogin = false;
  bool isShowNonCurrentWeek = false;
  bool isShowYear = false;
  bool isShowDate = false;
  bool isShowTime = false;
  bool isShowDesktopShortcut = false;
  String darkMode = '跟随系统';
  bool isSysColor = false;

  TextEditingController studentIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Optional
  @override
  void init() {
    // It's called after the MVVM widget's initState is called
    _loadSettings();
  }

  // Optional
  @override
  void onBuild() {
    // A callback when the `build` method of the view is called.
  }

  _loadSettings() {
    isLogin = DataStorage.prefs!.getString(DataStorage.keyCookie) != null;
    isShowNonCurrentWeek =
        DataStorage.prefs!.getBool(DataStorage.keyIsShowNonCurrentWeek) ??
            false;
    isShowYear = DataStorage.prefs!.getBool(DataStorage.keyIsShowYear) ?? false;
    isShowDate = DataStorage.prefs!.getBool(DataStorage.keyIsShowDate) ?? false;
    isShowTime = DataStorage.prefs!.getBool(DataStorage.keyIsShowTime) ?? false;
    isShowDesktopShortcut =
        DataStorage.prefs!.getBool(DataStorage.keyIsShowDesktopShortcut) ??
            false;
    darkMode = DataStorage.prefs!.getString(DataStorage.keyDarkMode) ?? '跟随系统';
    isSysColor = DataStorage.prefs!.getBool(DataStorage.keyIsSysColor) ?? false;
    notifyListeners();
  }

  void setIsShowNonCurrentWeek(bool value) {
    DataStorage.prefs!.setBool(DataStorage.keyIsShowNonCurrentWeek, value);
    isShowNonCurrentWeek = value;
    notifyListeners();
  }

  void setIsShowYear(bool value) {
    DataStorage.prefs!.setBool(DataStorage.keyIsShowYear, value);
    isShowYear = value;
    notifyListeners();
  }

  void setIsShowDate(bool value) {
    DataStorage.prefs!.setBool(DataStorage.keyIsShowDate, value);
    isShowDate = value;
    notifyListeners();
  }

  void setIsShowTime(bool value) {
    DataStorage.prefs!.setBool(DataStorage.keyIsShowTime, value);
    isShowTime = value;
    notifyListeners();
  }

  void setIsShowDesktopShortcut(bool value) {
    DataStorage.prefs!.setBool(DataStorage.keyIsShowDesktopShortcut, value);
    isShowDesktopShortcut = value;
    notifyListeners();
  }

  void setDarkMode(String value) {
    DataStorage.prefs!.setString(DataStorage.keyDarkMode, value);
    darkMode = value;
    notifyListeners();
  }

  void setIsSysColor(bool value) {
    DataStorage.prefs!.setBool(DataStorage.keyIsSysColor, value);
    isSysColor = value;
    notifyListeners();
  }

  Future<void> login() async {
    final isSuccess = await ChaoxingService.login(
        studentIdController.text, passwordController.text);
    if (isSuccess) {
      DataStorage.prefs!
          .setString(DataStorage.keyStudentId, studentIdController.text);
      DataStorage.prefs!
          .setString(DataStorage.keyPassword, passwordController.text);
      if (context.mounted) Navigator.pop(context);
    }
  }

  Future<void> logout() async {
    DataStorage.prefs!.remove(DataStorage.keyCookie);
    DataStorage.prefs!.remove(DataStorage.keyStudentId);
    DataStorage.prefs!.remove(DataStorage.keyPassword);
    isLogin = false;
    notifyListeners();
  }
}

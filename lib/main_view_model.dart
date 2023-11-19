import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gong_yun/api/data_storage_service.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:window_manager/window_manager.dart';

class MainViewModel extends ViewModel with WindowListener {
  int selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.selected;
  bool isLargeScreenMode = false;
  bool isSysColor = DataStorage.prefs!.getBool(DataStorage.keyIsSysColor) ??
      DataStorage.defaultValueIsSysColor;
  String darkMode = DataStorage.prefs!.getString(DataStorage.keyDarkMode) ??
      DataStorage.defaultValueDarkMode;

  void setIsSysColor(bool value) {
    isSysColor = value;
    notifyListeners();
  }

  void setDarkMode(String value) {
    darkMode = value;
    notifyListeners();
  }

  void setSelectedIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }

  Future<void> detectLargeScreenMode() async {
    isLargeScreenMode = (await windowManager.getSize()).width >= 845;
    notifyListeners();
  }

  @override
  init() async {
    windowManager.addListener(this);
    await windowManager.setPreventClose(true);
  }

  @override
  void onWindowResize() async {
    await detectLargeScreenMode();
    super.onWindowResized();
  }

  @override
  void onWindowMaximize() async {
    await detectLargeScreenMode();
    super.onWindowMaximize();
  }

  @override
  void onWindowUnmaximize() async {
    await detectLargeScreenMode();
    super.onWindowUnmaximize();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('退出应用'),
            content: const Text('确认退出应用吗？'),
            actions: [
              TextButton(
                child: const Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('确认'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await windowManager.destroy();
                },
              ),
            ],
          );
        },
      );
    }
  }
}

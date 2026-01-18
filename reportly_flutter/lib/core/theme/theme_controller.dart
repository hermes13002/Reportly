import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // Observable for ThemeMode
  final _themeMode = ThemeMode.dark.obs;
  ThemeMode get themeMode => _themeMode.value;

  // Toggle theme
  void toggleTheme() {
    if (_themeMode.value == ThemeMode.dark) {
      _themeMode.value = ThemeMode.light;
      Get.changeThemeMode(ThemeMode.light);
    } else {
      _themeMode.value = ThemeMode.dark;
      Get.changeThemeMode(ThemeMode.dark);
    }
  }

  // Set specific mode
  void setThemeMode(ThemeMode mode) {
    _themeMode.value = mode;
    Get.changeThemeMode(mode);
  }
}

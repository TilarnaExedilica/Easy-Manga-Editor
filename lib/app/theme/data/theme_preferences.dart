import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:easy_manga_editor/core/storage/app_storage.dart';

@injectable
class ThemePreferences {
  final AppStorage _storage;
  static const String _themeKey = 'theme_mode';

  ThemePreferences(this._storage);

  Future<ThemeMode> getThemeMode() async {
    final value = await _storage.getString(_themeKey);
    return _parseThemeMode(value);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _storage.setString(_themeKey, mode.toString());
  }

  ThemeMode _parseThemeMode(String? value) {
    switch (value) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_setup_riverpod/core/themes/app_colors.dart';
import 'package:flutter_setup_riverpod/core/themes/app_theme.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  CupertinoThemeData get cupertinoTheme => CupertinoTheme.of(this);

  bool get isDarkMode => theme.brightness == Brightness.dark;

  ThemeData get appTheme =>
      isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

  CupertinoThemeData get appCupertinoTheme =>
      isDarkMode ? AppTheme.cupertinoDarkTheme : AppTheme.cupertinoLightTheme;

  ThemeData get appLightTheme => AppTheme.lightTheme;

  ThemeData get appDarkTheme => AppTheme.darkTheme;

  CupertinoThemeData get appCupertinoLightTheme => AppTheme.cupertinoLightTheme;

  CupertinoThemeData get appCupertinoDarkTheme => AppTheme.cupertinoDarkTheme;

  SemanticColors get semantic => AppColors.semantic;
}

extension ThemeColors on BuildContext {
  AppColorsTheme get colors {
    return Theme.of(this).brightness == Brightness.light
        ? AppColorsTheme.light()
        : AppColorsTheme.dark();
  }
}

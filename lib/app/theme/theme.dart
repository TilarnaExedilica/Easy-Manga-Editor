import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:easy_manga_editor/app/theme/styles/colors.dart';
import 'package:easy_manga_editor/core/utils/constants/ui_constants.dart';

class AppTheme {
  static const animationDuration = Duration(milliseconds: 300);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primaryDark,
      surface: AppColors.surfaceLight,
      surfaceContainerHighest: AppColors.surfaceContainerHighestLight,
      secondaryContainer: AppColors.secondaryContainerLight,
      error: AppColors.error,
      outline: AppColors.outlineLight,
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.dialogBackgroundLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radius),
        side: const BorderSide(
          color: AppColors.outlineLight,
          width: 1.5,
        ),
      ),
    ),
    fontFamily: 'LexendDeca',
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.drawerBackgroundLight,
      width: UIConstants.drawerWidth,
      elevation: 0,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: SharedAxisPageTransitionsBuilder(
          transitionType: SharedAxisTransitionType.horizontal,
        ),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.primaryLight,
      surface: AppColors.surfaceDark,
      surfaceContainerHighest: AppColors.surfaceContainerHighestDark,
      secondaryContainer: AppColors.secondaryContainerDark,
      error: AppColors.errorDark,
      outline: AppColors.outlineDark,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.dialogBackgroundDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radius),
        side: const BorderSide(
          color: AppColors.outlineDark,
          width: 1.5,
        ),
      ),
    ),
    fontFamily: 'LexendDeca',
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.drawerBackgroundDark,
      width: UIConstants.drawerWidth,
      elevation: 0,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: SharedAxisPageTransitionsBuilder(
          transitionType: SharedAxisTransitionType.horizontal,
        ),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}

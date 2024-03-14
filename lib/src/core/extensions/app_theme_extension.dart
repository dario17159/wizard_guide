import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wizard_guide/src/config/theme/app_colors.dart';
import 'package:wizard_guide/src/config/theme/dark_colors.dart';
import 'package:wizard_guide/src/config/theme/light_colors.dart';

ThemeData lightTheme(TextTheme textTheme) => ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: LightColors.primary,
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness:
              Platform.isIOS ? Brightness.light : Brightness.dark,
          systemNavigationBarIconBrightness:
              Platform.isIOS ? Brightness.light : Brightness.dark,
          statusBarIconBrightness:
              Platform.isIOS ? Brightness.light : Brightness.dark,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          // foregroundColor: const MaterialStatePropertyAll(LightColors.primary),
        ),
      ),
      // scaffoldBackgroundColor: LightColors.textPrimary,
      extensions: <ThemeExtension<dynamic>>[
        AppColors.light,
      ],
    );

ThemeData darkTheme(TextTheme textTheme) => ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: DarkColors.primary,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color(0xff1E1D22),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xff1E1D22),
        titleTextStyle: textTheme.headlineSmall?.copyWith(color: DarkColors.textColorSecondary),
        iconTheme: const IconThemeData(
          color: DarkColors.textColorSecondary
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness:
              Platform.isIOS ? Brightness.light : Brightness.dark,
          systemNavigationBarIconBrightness:
              Platform.isIOS ? Brightness.light : Brightness.dark,
          statusBarIconBrightness:
              Platform.isIOS ? Brightness.light : Brightness.dark,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          backgroundColor: const MaterialStatePropertyAll(DarkColors.primary),
          foregroundColor: const MaterialStatePropertyAll(DarkColors.textColorSecondary),
        ),
      ),
      // scaffoldBackgroundColor: DarkColors.textPrimary,
      extensions: <ThemeExtension<dynamic>>[
        AppColors.dark,
      ],
    );

extension AppThemeExtension on ThemeData {
  /// Usage example: Theme.of(context).appColors;
  AppColors get appColors =>
      extension<AppColors>() ?? lightTheme(textTheme).extension<AppColors>()!;
}

extension ThemeGetter on BuildContext {
  ThemeData get appTheme => Theme.of(this);
  AppColors get appColors => Theme.of(this).appColors;
}

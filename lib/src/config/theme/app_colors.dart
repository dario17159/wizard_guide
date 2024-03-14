import 'package:flutter/material.dart';
import 'package:wizard_guide/src/config/theme/dark_colors.dart';
import 'package:wizard_guide/src/config/theme/light_colors.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color primary;
  final Color secondary;
  final Color textColorPrimary;
  final Color textColorSecondary;
  final Color appBackground;

  AppColors({
    required this.primary,
    required this.secondary,
    required this.textColorPrimary,
    required this.textColorSecondary,
    required this.appBackground,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primary,
    Color? secondary,
    Color? textColorPrimary,
    Color? textColorSecondary,
    Color? appBackground,
  }) =>
      AppColors(
        primary: primary ?? this.primary,
        secondary: secondary ?? this.secondary,
        textColorPrimary: textColorPrimary ?? this.textColorPrimary,
        textColorSecondary: textColorSecondary ?? this.textColorSecondary,
        appBackground: appBackground ?? this.appBackground,
      );

  @override
  ThemeExtension<AppColors> lerp(
      covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      textColorPrimary: Color.lerp(textColorPrimary, other.textColorPrimary, t)!,
      textColorSecondary: Color.lerp(textColorSecondary, other.textColorSecondary, t)!,
      appBackground: Color.lerp(appBackground, other.appBackground, t)!,
    );
  }

  static final light = AppColors(
    primary: LightColors.primary,
    secondary: LightColors.secondary,
    textColorPrimary: LightColors.textColorPrimary,
    textColorSecondary: LightColors.textColorSecondary,
    appBackground: LightColors.appBackground,
  );

  static final dark = AppColors(
    primary: DarkColors.primary,
    secondary: DarkColors.secondary,
    textColorPrimary: DarkColors.textColorPrimary,
    textColorSecondary: DarkColors.textColorSecondary,
    appBackground: DarkColors.appBackground,
  );
}

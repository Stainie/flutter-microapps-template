import 'package:design_system/core/foundations/colors.dart';
import 'package:design_system/core/foundations/typography.dart';
import 'package:flutter/material.dart';

class FoundationThemes {
  FoundationThemes._();

  static final lightTheme = ThemeData(
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: FoundationTypography.familyTextStandard,
        fontSize: FoundationTypography.fontSize48,
        letterSpacing: FoundationTypography.letterSpacing0,
        color: FoundationColors.textRegular,
        height: FoundationTypography.lineHeightText1,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: TextStyle(
        fontFamily: FoundationTypography.familyTextStandard,
        fontSize: FoundationTypography.fontSize36,
        letterSpacing: FoundationTypography.letterSpacing0,
        color: FoundationColors.textRegular,
        height: FoundationTypography.lineHeightText1_1,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontFamily: FoundationTypography.familyTextStandard,
        fontSize: FoundationTypography.fontSize18,
        letterSpacing: FoundationTypography.letterSpacing1,
        color: FoundationColors.textRegular,
        height: FoundationTypography.lineHeightText1_3,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        fontFamily: FoundationTypography.familyTextStandard,
        fontSize: FoundationTypography.fontSize16,
        letterSpacing: FoundationTypography.letterSpacing2,
        color: FoundationColors.textRegular,
        height: FoundationTypography.lineHeightText1_2,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        fontFamily: FoundationTypography.familyTextStandard,
        fontSize: FoundationTypography.fontSize14,
        letterSpacing: FoundationTypography.letterSpacing2,
        color: FoundationColors.textRegular,
        height: FoundationTypography.lineHeightText1_3,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: TextStyle(
        fontFamily: FoundationTypography.familyTextStandard,
        fontSize: FoundationTypography.fontSize18,
        letterSpacing: FoundationTypography.letterSpacing1,
        height: FoundationTypography.lineHeightText1_3,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontFamily: FoundationTypography.familyTextStandard,
        fontSize: FoundationTypography.fontSize16,
        letterSpacing: FoundationTypography.letterSpacing1,
        height: FoundationTypography.lineHeightText1,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontFamily: FoundationTypography.familyTextStandard,
        fontSize: FoundationTypography.fontSize10,
        letterSpacing: FoundationTypography.letterSpacing2,
        height: FoundationTypography.lineHeightText1_4,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        fontFamily: FoundationTypography.familyTextStandard,
        fontSize: FoundationTypography.fontSize18,
        letterSpacing: FoundationTypography.letterSpacing1,
        color: FoundationColors.textRegular,
        height: FoundationTypography.lineHeightText1,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        fontFamily: FoundationTypography.familyTextStandard,
        fontSize: FoundationTypography.fontSize16,
        letterSpacing: FoundationTypography.letterSpacing1,
        color: FoundationColors.textRegular,
        height: FoundationTypography.lineHeightText1_25,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontFamily: FoundationTypography.familyTextStandard,
        fontSize: FoundationTypography.fontSize14,
        letterSpacing: FoundationTypography.letterSpacing2,
        color: FoundationColors.textRegular,
        height: FoundationTypography.lineHeightText1,
        fontWeight: FontWeight.w500,
      ),
      displayLarge: TextStyle(
        fontFamily: FoundationTypography.familyTextStandard,
        fontSize: FoundationTypography.fontSize18,
        letterSpacing: FoundationTypography.letterSpacing1,
        color: FoundationColors.textRegular,
        height: FoundationTypography.lineHeightText1_3,
        fontWeight: FontWeight.w500,
      ),
      displayMedium: TextStyle(
        fontFamily: FoundationTypography.familyTextStandard,
        fontSize: FoundationTypography.fontSize16,
        letterSpacing: FoundationTypography.letterSpacing2,
        color: FoundationColors.textRegular,
        height: FoundationTypography.lineHeightText1_3,
        fontWeight: FontWeight.w500,
      ),
      displaySmall: TextStyle(
        fontFamily: FoundationTypography.familyTextStandard,
        fontSize: FoundationTypography.fontSize14,
        letterSpacing: FoundationTypography.letterSpacing2,
        color: FoundationColors.textRegular,
        height: FoundationTypography.lineHeightText1_3,
      ),
    ),
    appBarTheme: const AppBarTheme(color: FoundationColors.bgAppBar),
    outlinedButtonTheme: const OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(
          FoundationColors.circleButtonBgLight,
        ),
        shape: MaterialStatePropertyAll<OutlinedBorder>(CircleBorder()),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      fillColor: FoundationColors.dropdownBg,
      filled: true,
    ),
    checkboxTheme: CheckboxThemeData(
      splashRadius: 0,
      fillColor: MaterialStateProperty.all(FoundationColors.checkboxBg),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      checkColor: MaterialStateProperty.all(FoundationColors.checkboxCheck),
      shape: const RoundedRectangleBorder(),
    ),
    chipTheme: const ChipThemeData(
      padding: EdgeInsets.zero,
      backgroundColor: FoundationColors.chipLight,
      selectedColor: FoundationColors.chipSelected,
      shape: StadiumBorder(),
    ),
    switchTheme: const SwitchThemeData(
        thumbColor: MaterialStatePropertyAll(FoundationColors.switchActive),
        trackColor: MaterialStatePropertyAll(FoundationColors.switchInactive),
        splashRadius: 0,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
  );

  static final darkTheme = ThemeData();
}

import 'package:flutter/material.dart';
import 'package:flutter_store/utils/theme/custom_theme/appbar_theme.dart';
import 'package:flutter_store/utils/theme/custom_theme/bottom_sheet_theme.dart';
import 'package:flutter_store/utils/theme/custom_theme/checkbox_theme.dart';
import 'package:flutter_store/utils/theme/custom_theme/chip_theme.dart';
import 'package:flutter_store/utils/theme/custom_theme/elevated_button_theme.dart';
import 'package:flutter_store/utils/theme/custom_theme/outlined_button_theme.dart';
import 'package:flutter_store/utils/theme/custom_theme/text_field_theme.dart';
import 'package:flutter_store/utils/theme/custom_theme/text_theme.dart';

import '../constants/colors.dart';

class TAppTheme{
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: TColors.primary,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    chipTheme: TChipTheme.lightChipTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme
  );
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: TColors.primary,
      scaffoldBackgroundColor: Colors.black,
      textTheme: TTextTheme.darkTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
      appBarTheme: TAppBarTheme.darkAppBarTheme,
      checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
      bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
      chipTheme: TChipTheme.darkChipTheme,
      inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme
  );
}


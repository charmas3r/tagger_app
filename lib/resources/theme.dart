import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class PlantTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
      useMaterial3: true,
      primarySwatch: ThemeColors.olivine,
      fontFamily: 'Planter',
      scaffoldBackgroundColor: Colors.white,
      highlightColor: Colors.white,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Colors.white,
        onPrimary: ThemeColors.darkMossGreen,
        secondary: ThemeColors.olivine,
        onSecondary: Colors.white,
        tertiary: ThemeColors.alabaster,
        onTertiary: ThemeColors.komboGreen,
        error: Colors.red,
        onError: Colors.white,
        background: Colors.white,
        onBackground: ThemeColors.olivine,
        surface: Colors.white,
        onSurface: ThemeColors.olivine,
      ),
      buttonTheme: ButtonThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: ThemeColors.olivine,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 8
      ),
    );
  }
}

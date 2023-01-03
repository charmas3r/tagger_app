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
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ThemeColors.olivine)
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ThemeColors.olivine),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: ThemeColors.olivine),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: ThemeColors.olivine,
        selectionHandleColor: ThemeColors.olivine,
        selectionColor: ThemeColors.olivine.shade200,
      ),
      buttonTheme: ButtonThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: ThemeColors.olivine,
      ),
      navigationBarTheme: NavigationBarThemeData(
          indicatorColor: ThemeColors.alabaster,
          iconTheme: MaterialStateProperty.resolveWith((states) {
            return IconThemeData(color: ThemeColors.darkMossGreen);
          }),
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            return TextStyle(fontSize: 14, color: ThemeColors.darkMossGreen);
      })),
      appBarTheme: const AppBarTheme(elevation: 8),
    );
  }
}

import 'package:flutter/material.dart';

import 'colors.dart';

class PlantTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
      useMaterial3: true,
      primarySwatch: ThemeColors.veniceBlue,
      fontFamily: 'Montserrat',
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: ThemeColors.veniceBlue,
        onPrimary: Colors.white,
        secondary: ThemeColors.veniceBlue,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        background: Colors.white,
        onBackground: Colors.black38,
        surface: Colors.white70,
        onSurface: Colors.black38,
      ),
      buttonTheme: ButtonThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: ThemeColors.veniceBlue,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 8,
      ),
    );
  }
}

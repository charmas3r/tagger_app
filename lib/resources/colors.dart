import 'dart:ui';

import 'package:flutter/material.dart';


class ThemeColors {

  static const MaterialColor veniceBlue = MaterialColor(
    _veniceBluePrimaryValue,
    <int, Color>{
      50: Color.fromRGBO(7, 96, 123, .1),
      100: Color.fromRGBO(7, 96, 123, .2),
      200: Color.fromRGBO(7, 96, 123, .3),
      300: Color.fromRGBO(7, 96, 123, .4),
      400: Color.fromRGBO(7, 96, 123, .5),
      500: Color.fromRGBO(7, 96, 123, .6),
      600: Color.fromRGBO(7, 96, 123, .7),
      700: Color.fromRGBO(7, 96, 123, .8),
      800: Color.fromRGBO(7, 96, 123, .9),
      900: Color.fromRGBO(7, 96, 123, 1),
    },
  );

  static const int _veniceBluePrimaryValue = 0xFF07607B;
}

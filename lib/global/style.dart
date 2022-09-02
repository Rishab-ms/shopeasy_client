// class that contains the styles for the app
import 'dart:math';

import 'package:flutter/material.dart';

class Styles {
// //accents
//   static const Color primaryColor = Color(0xFF0E74BC);

//   //shades
//   static const Color darkerShade = Color(0xFF13293D);
//   static const lighterShade = Color(0xFF00A6FB);
  static const darkGrey = Color(0xFF414141);
  static const lightGrey = Color(0xFFEEE5E9);
  static const lightThemeGrey = Color.fromARGB(255, 245, 245, 245);
  static const darkThemeGrey = Color.fromRGBO(66, 66, 66, 1);

  //methods

  //method to return the grey color depending on the theme of the device
  static Color getGrey(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark
        ? darkThemeGrey
        : lightThemeGrey;
  }

  static getRandomColor() {
    //return a random pastel color
    return Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255),
        Random().nextInt(255));
  }
}

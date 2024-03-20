import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  listTileTheme: ListTileThemeData(
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: Colors.black,
      fontSize: 45,
      fontWeight: FontWeight.w900,
    ),
  ),
  colorScheme: ColorScheme.light(
    background: Colors.white,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.black, // Use primary instead of foregroundColor
    ),
  ),
);

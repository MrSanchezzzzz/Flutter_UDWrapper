import 'package:flutter/material.dart';
import 'package:urban_dictionary_wrapper/utils.dart';

class Themes {
  static ThemeData darkTheme =
  ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color.fromARGB(255, 27, 41, 54).toMaterialColor(),
      scaffoldBackgroundColor: const Color.fromARGB(255,16, 21, 27),
      appBarTheme: AppBarTheme(
          backgroundColor:
          const Color.fromARGB(255, 27, 41, 54).toMaterialColor(),
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400
          )
      ),
      backgroundColor: const Color.fromARGB(255, 27, 41, 54).toMaterialColor(),
      indicatorColor: Color.fromARGB(255, 239, 255, 0),
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color.fromARGB(255, 16, 21, 27),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          focusedBorder: OutlineInputBorder(
              borderSide:
              const BorderSide(color: Colors.white, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(16)),
          hintStyle: const TextStyle(color: Colors.white24)),
      textTheme: const TextTheme(
        caption: TextStyle(color: Colors.white, fontSize: 36),
        subtitle1: TextStyle(color: Colors.white),
        headline1: TextStyle(
            fontSize: 57,
            color: Color.fromARGB(255, 239, 255, 0),
            fontWeight: FontWeight.bold
        ),
        headline4: TextStyle(
          fontSize: 36,
          color: Color.fromARGB(255, 239, 255, 0),
          fontWeight: FontWeight.bold
      ),
        bodyText1: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.normal
        ),
        bodyText2: TextStyle(
            color: Colors.white10,
            fontSize: 24,
            fontWeight: FontWeight.normal
        ),
      ),
      canvasColor: const Color.fromARGB(255,16, 21, 27).toMaterialColor(),
  );

  static ThemeData lightTheme =
  ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color.fromARGB(255, 27, 41, 54).toMaterialColor(),
    backgroundColor: const Color.fromARGB(192, 27, 41, 54).toMaterialColor(),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        backgroundColor:
        const Color.fromARGB(255, 27, 41, 54).toMaterialColor(),
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400
        )
    ),

    indicatorColor: Color.fromARGB(255, 27, 41, 54),

      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white24,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          focusedBorder: OutlineInputBorder(
              borderSide:
              const BorderSide(color: Colors.white, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(16)),
          hintStyle: const TextStyle(color: Colors.white24)),

    textTheme: const TextTheme(
      caption: TextStyle(
          fontSize: 36,
          color: Colors.white
      ),
      headline1: TextStyle(
          fontSize: 57,
          color: Color.fromARGB(255, 239, 255, 0),
          fontWeight: FontWeight.bold
      ),
      headline4: TextStyle(
          fontSize: 36,
          color: Color.fromARGB(255, 239, 255, 0),
          fontWeight: FontWeight.bold
      ),
      bodyText1: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.normal
      ),
      bodyText2: TextStyle(
          fontSize: 24,
          color: Colors.black54,
          fontWeight: FontWeight.normal
      ),
    ),
  );
}
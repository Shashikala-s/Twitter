import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyTheme {


  static final lightTheme = ThemeData(

      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.lightBlue,
      buttonTheme: ButtonThemeData(buttonColor: Colors.grey[100]),
      iconTheme: IconThemeData(
        color: Colors.grey[300],
      ),

      backgroundColor: Colors.white,
      cardColor: Colors.grey[100],
      focusColor: Colors.lightBlue,
      textTheme: const TextTheme(
          ),
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.dark),
      colorScheme: const ColorScheme.light()
          .copyWith(secondary: Colors.lightBlue,));
}

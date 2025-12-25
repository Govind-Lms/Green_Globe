import 'package:flutter/material.dart';

class MyTheme {
  static final light = ThemeData(
    primaryColorDark: const Color(0xff007084),
    primaryColorLight: const Color(0xfffff7f1),
    primaryColor: const Color(0xff007084),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xfffff7f1),
      elevation: 0,
      // selectedIconTheme: IconThemeData(color: Colors.black)
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xff007084),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 18.0),
    ),
  );

  static final dark = ThemeData(
    primaryColorLight: const Color(0xff007084),
    primaryColorDark: const Color(0xfffff7f1),
    primaryColor: const Color(0xff007084),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xff1a1a1a),
      elevation: 0,
      // unselectedIconTheme: IconThemeData(color: Colors.white),
      // unselectedLabelStyle: TextStyle(color: Colors.white),
      // unselectedItemColor: Colors.white,
      // selectedIconTheme: IconThemeData(color: Colors.white)
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xff007084),
      centerTitle: true,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 18.0),
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
}

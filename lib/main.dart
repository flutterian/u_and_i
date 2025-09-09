import 'package:flutter/material.dart';
import 'package:u_and_i/screen/home_screen.dart';

void main() {
  // build() 함수에 입력되지 않은 값들은 핫 리로드 반영이 되지 않는다.
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'sunflower',
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            fontSize: 80.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'parisienne',
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 50.0,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(color: Colors.white, fontSize: 30.0),
          bodyMedium: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
      home: HomeScreen(),
    ),
  );
}

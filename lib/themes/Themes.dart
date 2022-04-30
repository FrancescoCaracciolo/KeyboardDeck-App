import 'package:flutter/material.dart';

class KBThemeData {
  KBThemeData(
      {Key? key,
      required this.images,
      required this.defaultImage,
      required this.angle,
      required this.bottomOffset,
      required this.timePostion,
      required this.wpmPosition,
      required this.aspectRatio,
      required this.defaultTextstyle,
      required this.textSize,
      required this.appTheme});
  List<String> images;
  String defaultImage;
  double aspectRatio;
  double angle;
  double bottomOffset;
  double timePostion;
  double wpmPosition;
  double textSize;
  TextStyle defaultTextstyle;
  ThemeData appTheme;
}

Map<String, KBThemeData> THEMES = {
  "light": KBThemeData(
      images: [
        'assets/bongo_cat2_right.png',
        'assets/bongo_cat2_left.png',
        'assets/bongo_cat2_both.png'
      ],
      defaultImage: 'assets/bongo_cat2.png',
      aspectRatio: 230 / 108,
      angle: 13 / 360,
      bottomOffset: 6,
      timePostion: 7 / 8,
      wpmPosition: 1 / 8,
      textSize: 1 / 30,
      defaultTextstyle: const TextStyle(
          fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
      appTheme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: Colors.white38,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[500],
      )),
  "dark": KBThemeData(
      images: [
        'assets/bongo_cat2_right.png',
        'assets/bongo_cat2_left.png',
        'assets/bongo_cat2_both.png'
      ],
      defaultImage: 'assets/bongo_cat2.png',
      aspectRatio: 230 / 108,
      angle: 13 / 360,
      bottomOffset: 6,
      timePostion: 7 / 8,
      wpmPosition: 1 / 8,
      textSize: 1 / 29,
      defaultTextstyle: const TextStyle(
          fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
      appTheme: ThemeData(
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[500],
      ))
};

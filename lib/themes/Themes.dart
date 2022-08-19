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
      required this.textTopOffset,
      required this.textLeftOffset,
      required this.textSize,
      required this.appTheme,
      required this.tablecolor});
  List<String> images;
  String defaultImage;
  double aspectRatio;
  double angle;
  Color tablecolor;
  double bottomOffset;
  double timePostion;
  double wpmPosition;
  double textTopOffset;
  double textLeftOffset;
  double textSize;
  TextStyle defaultTextstyle;
  ThemeData appTheme;
}

Map<String, KBThemeData> THEMES = {
  "light": KBThemeData(
      images: [
        'assets/default_light/BongoCat2.png',
        'assets/default_light/BongoCat3.png',
        'assets/default_light/BongoCat4.png',
      ],
      defaultImage: 'assets/default_light/BongoCat1.png',
      aspectRatio: 230 / 108,
      angle: 13 / 360,
      bottomOffset: 0,
      timePostion: 7 / 8,
      wpmPosition: 1 / 8,
      textTopOffset: 1 / 7,
      textLeftOffset: 1 / 10,
      textSize: 1 / 30,
      defaultTextstyle:
          const TextStyle(fontWeight: FontWeight.bold, fontFamily: "CatCafe"),
      appTheme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: Colors.grey,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[500],
      ),
      tablecolor: Colors.white),
  "megumin": KBThemeData(
      images: [
        'assets/megumin/BongoCat2.png',
        'assets/megumin/BongoCat3.png',
        'assets/megumin/BongoCat4.png',
      ],
      defaultImage: 'assets/megumin/BongoCat1.png',
      aspectRatio: 230 / 108,
      angle: 12.7 / 360,
      bottomOffset: 0,
      timePostion: 7 / 8,
      wpmPosition: 1 / 8,
      textTopOffset: 1 / 7,
      textLeftOffset: 1 / 10,
      textSize: 1 / 30,
      defaultTextstyle:
          const TextStyle(fontWeight: FontWeight.bold, fontFamily: "CatCafe"),
      appTheme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: Color(0xFFf42a24),
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[500],
      ),
      tablecolor: Colors.white),
  "dark": KBThemeData(
      images: [
        'assets/default_dark/BongoCat2.png',
        'assets/default_dark/BongoCat3.png',
        'assets/default_dark/BongoCat4.png',
      ],
      defaultImage: 'assets/default_dark/BongoCat1.png',
      aspectRatio: 230 / 108,
      angle: 13 / 360,
      bottomOffset: 0,
      timePostion: 7 / 8,
      wpmPosition: 1 / 8,
      textTopOffset: 1 / 7,
      textLeftOffset: 1 / 10,
      textSize: 1 / 30,
      defaultTextstyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: "CatCafe",
          color: Colors.white),
      appTheme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Color(0xFF181818),
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[500],
      ),
      tablecolor: Color(0xFF393939)),
};

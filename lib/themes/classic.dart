import 'package:flutter/widgets.dart';

class KBThemeData {
  KBThemeData(
      {Key? key,
      required this.images,
      required this.defaultImage,
      required this.angle,
      required this.timePostion,
      required this.wpmPosition,
      required this.aspectRatio,
      required this.defaultTextstyle,
      required this.textSize});
  List<String> images;
  String defaultImage;
  double aspectRatio;
  double angle;
  double timePostion;
  double wpmPosition;
  double textSize;
  TextStyle defaultTextstyle;
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
    timePostion: 7 / 8,
    wpmPosition: 1 / 8,
    textSize: 1 / 30,
    defaultTextstyle:
        const TextStyle(fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
  )
};

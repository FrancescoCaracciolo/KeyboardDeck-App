import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  ThemeData theme;

  ThemeModel({Key? key, required this.theme}) : super();

  set setTheme(ThemeData value) {
    theme = value;
    notifyListeners();
  }
}

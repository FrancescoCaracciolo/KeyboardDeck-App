import 'package:flutter/material.dart';
import 'package:keyboard/themes/Themes.dart';

class InfoText extends StatelessWidget {
  InfoText(
      {Key? key, required this.text, required this.theme, required this.size})
      : super(key: key);
  KBThemeData theme;
  double size;
  String text;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
        child: Text(text,
            style: theme.defaultTextstyle
                .copyWith(fontSize: size * theme.textSize)),
        turns: AlwaysStoppedAnimation(theme.angle));
  }
}

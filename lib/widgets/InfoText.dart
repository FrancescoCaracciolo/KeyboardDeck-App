import 'package:flutter/material.dart';
import 'package:keyboard/themes/Themes.dart';

class InfoText extends StatelessWidget {
  InfoText(
      {Key? key,
      required this.text,
      required this.theme,
      required this.size,
      this.subtext})
      : super(key: key);
  KBThemeData theme;
  double size;
  String text;
  String? subtext;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
                text: text,
                style: theme.defaultTextstyle
                    .copyWith(fontSize: size * theme.textSize)),
            subtext != null
                ? TextSpan(
                    text: "\n" + (subtext as String),
                    style: theme.defaultTextstyle
                        .copyWith(fontSize: size * theme.textSize * 2 / 3))
                : TextSpan()
          ]),
        ),
        turns: AlwaysStoppedAnimation(theme.angle));
  }
}

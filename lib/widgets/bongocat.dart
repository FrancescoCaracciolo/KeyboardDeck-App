import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keyboard/themes/Themes.dart';
import 'package:keyboard/widgets/InfoText.dart';

class BongoCat extends StatefulWidget {
  BongoCat({
    Key? key,
    required this.width,
    required this.theme,
    required this.unit,
    this.wpm = 0,
    this.motd,
  }) : super(key: key);
  double width;
  int wpm = 0;
  KBThemeData theme;
  String? motd;
  String unit;

  @override
  State<BongoCat> createState() => BongoCatState();
}

class BongoCatState extends State<BongoCat> {
  String _timeString = "00:00"; // Init time string
  String _currentImage = "";
  String motd11 = "";
  String motd12 = "";
  late Timer timeTimer;
  @override
  void initState() {
    super.initState();
    _currentImage = widget.theme.defaultImage;
    timeTimer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => _getCurrentTime());
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: widget.theme.aspectRatio,
        child: SizedBox(
            width: widget.width, child: LayoutBuilder(builder: _layout)));
  }

  @override
  void dispose() {
    super.dispose();
    timeTimer.cancel();
  }

  Widget _layout(BuildContext context, BoxConstraints constraints) {
    return Container(
        child: Stack(children: [
      // BongoCat
      Image.asset(
        _currentImage,
        fit: BoxFit.fitWidth,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
      // Time Widget, to modularize
      Positioned(
          child: InfoText(
            text: _timeString,
            theme: widget.theme,
            size: constraints.maxWidth,
          ),
          bottom: ((constraints.maxWidth * widget.theme.timePostion) *
                      tan((widget.theme.angle) * 2 * pi) +
                  (constraints.maxWidth / 2) * widget.theme.textSize) +
              widget.theme.bottomOffset,
          right: constraints.maxWidth * widget.theme.timePostion),
      Positioned(
          child: InfoText(
            text: widget.unit +
                ": " +
                (widget.unit == "WPM"
                    ? widget.wpm.toString()
                    : (widget.wpm * 5).toString()),
            theme: widget.theme,
            size: constraints.maxWidth,
          ),
          bottom: ((constraints.maxWidth * widget.theme.wpmPosition) *
                      tan((widget.theme.angle) * 2 * pi) +
                  (constraints.maxWidth / 2) * widget.theme.textSize) +
              widget.theme.bottomOffset,
          right: constraints.maxWidth * widget.theme.wpmPosition),
      Positioned.fromRelativeRect(
        rect: RelativeRect.fromLTRB(
            constraints.maxHeight * widget.theme.textLeftOffset,
            constraints.maxWidth * widget.theme.textTopOffset,
            0,
            0),
        child: InfoText(
          text: motd11,
          subtext: motd12,
          theme: widget.theme,
          size: constraints.maxWidth,
        ),
      )
    ]));
  }

  void _getCurrentTime() {
    setState(() {
      _timeString = DateFormat("kk:mm").format(DateTime.now());
    });
  }

  void changeMotd(String? motd1) async {
    if (motd1 != null && motd1 != widget.motd) {
      List<String> split = motd1.split("\\auth//");
      if (split.length > 1) {
        motd11 = split[0];
        motd12 = split[1];
        setState(() {});
      } else {
        motd11 = motd1;
        setState(() {});
      }
      widget.motd = motd1;
    }
    setState(() {});
  }

  void press() async {
    // Makes a bongocat press
    Random rand = Random(DateTime.now().millisecond);
    int n = rand.nextInt(widget.theme.images.length);
    setState(() {
      _currentImage = widget.theme.images[n];
    });
    var _timer = Timer(Duration(milliseconds: 80), () {
      setState(() {
        _currentImage = widget.theme.defaultImage;
      });
    });
  }
}

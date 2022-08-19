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
  late Image _currentImage;
  late Image _defImage;
  List<Image> _images = [];
  String motd11 = "";
  String motd12 = "";
  late Timer timeTimer;
  late Timer restimer;
  @override
  void initState() {
    super.initState();
    loadImages();
    timeTimer = Timer.periodic(
        const Duration(seconds: 2), (Timer t) => _getCurrentTime());
    restimer = Timer(Duration(microseconds: 1), () {});
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: widget.theme.aspectRatio,
        child: SizedBox(
            width: widget.width, child: LayoutBuilder(builder: _layout)));
  }

  @override
  void didUpdateWidget(covariant BongoCat oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.theme != widget.theme) {
      loadImages(true); // Redo a precache image only if the theme is changed
    } else {
      loadImages();
    }
  }

  @override
  void didChangeDependencies() {
    loadImages(true); // precache images
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    timeTimer.cancel();
  }

  void loadImages([bool precache = false]) {
    // Loads images to avoid glitches, true if precache images is also needed
    _images = [];

    widget.theme.images.forEach((element) {
      Image image = Image.asset(
        element,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      );
      _images.add(image);
      if (precache) precacheImage(image.image, context);
    });
    _defImage = Image.asset(
      widget.theme.defaultImage,
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
    //_currentImage = _defImage;

    setState(() {});
  }

  Widget _layout(BuildContext context, BoxConstraints constraints) {
    return Container(
        color: widget.theme.appTheme.backgroundColor,
        child: Stack(children: [
          // BongoCat
          _currentImage,
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
      List<String> split = motd1.split('\\auth//');
      if (split.length > 1) {
        motd11 = split[0];
        motd12 = split[1];
        setState(() {});
      } else {
        motd11 = motd1;
        motd12 = "";
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
      _currentImage = _images[n];
    });
    if (restimer.isActive) {
      restimer.cancel();
    }
    restimer = Timer(Duration(milliseconds: 50), () {
      setState(() {
        _currentImage = _defImage;
      });
    });
  }
}

import 'dart:async';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard/themes/ThemeNotifier.dart';
import 'package:keyboard/widgets/bongocat.dart';
import 'package:keyboard/themes/Themes.dart';
import 'package:keyboard/utils/api.dart';
import 'package:keyboard/utils/routes.dart';
import 'package:keyboard/pages/settings.dart';
import 'package:keyboard/utils/wmpcounter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';

Map<String, Map<String, dynamic>> SETTINGS = {
  "unit": {
    "type": "String",
    "default": "WPM",
    "options": ["WPM", "CPM"],
  },
  "theme": {
    "type": "String",
    "default": "light",
    "options": ["light", "dark"],
  },
  "time": {
    "type": "int",
    "default": 15,
    "options": [5, 10, 15, 30, 45, 60],
  },
  "wakelock": {
    "type": "int",
    "default": 0,
    "options": [0, 1],
    "options_titles": ["Off", "On"],
  }
};

class BongoScene extends StatefulWidget {
  BongoScene({Key? key, this.themeNotifier}) : super(key: key);
  ThemeModel? themeNotifier;
  @override
  State<BongoScene> createState() => _BongoScene();
}

class _BongoScene extends State<BongoScene> {
  SharedPreferences? prefs;
  String currentImage = 'assets/bongo_cat2.png';
  var images = [
    'assets/bongo_cat2_right.png',
    'assets/bongo_cat2_left.png',
    'assets/bongo_cat2_both.png'
  ];
  bool disposed = false;
  String _timeString = "00:00"; // Init time string
  int _currentWPM = 0; // Init WPM int
  ApiManager api = ApiManager(); // Init API Manager
  WPMCounter wpm = WPMCounter(30); // Init WPM counter
  GlobalKey<BongoCatState> _myKey = GlobalKey();
  String theme = SETTINGS["theme"]?["default"];
  String unit = SETTINGS["unit"]?["default"];
  int time = SETTINGS["time"]?["default"];
  late Timer wpmTimer;
  late Timer timeTimer;

  @override
  void initState() {
    super.initState();
    // Only Landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    // Hide UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    // Update time
    wpmTimer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => _getCurrentTime());
    timeTimer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => calculateWPM());
    // Start making requests
    startUpdate();
    // Get settings
    _getSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BongoCat(
        key: _myKey,
        width: MediaQuery.of(context).size.width,
        theme: THEMES[theme] as KBThemeData,
        unit: unit,
        wpm: _currentWPM,
      ),
      // Temporary Buttons
      floatingActionButton: Column(children: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            press();
          },
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            _openSettings();
          },
        )
      ]),
    );
  }

  void press() async {
    // Makes a bongocat press
    _myKey.currentState?.press();
  }

  void calculateWPM() {
    _currentWPM = wpm.calculateWPM(time);
    setState(() {
      _currentWPM;
    });
  }

  void _openSettings() {
    Navigator.pushReplacement(
        context,
        FadeRoute(
            page: SettingsPage(
          api: api,
          themeNotifier: widget.themeNotifier,
        )));
  }

  void _getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    SETTINGS.forEach((key, value) {
      if (SETTINGS[key]?["type"] == "String") {
        String? setting = prefs.getString(key);
        if (setting == null) {
          prefs.setString(key, SETTINGS[key]?["default"]);
          setting = SETTINGS[key]?["default"];
        }

        switch (key) {
          case 'theme':
            theme = setting as String;
            if (THEMES[theme]?.appTheme != null)
              widget.themeNotifier?.setTheme =
                  THEMES[theme]?.appTheme as ThemeData;
            break;
          case 'unit':
            unit = setting as String;
            break;
        }
      } else if (SETTINGS[key]?["type"] == "int") {
        int? setting = prefs.getInt(key);
        if (setting == null) {
          prefs.setInt(key, SETTINGS[key]?["default"]);
          setting = SETTINGS[key]?["default"];
        }

        switch (key) {
          case 'time':
            time = setting as int;
            break;
          case 'wakelock':
            if (setting as int == 1) {
              if (!Platform.isLinux) Wakelock.enable();
            } else {
              if (!Platform.isLinux) Wakelock.disable();
            }
            break;
        }
      }
    });
    setState(() {});
  }

  void _getCurrentTime() {
    setState(() {
      _timeString = DateFormat("kk:mm").format(DateTime.now());
    });
  }

  // Start client
  Future<void> startUpdate() async {
    await Future.delayed(Duration.zero);
    while (true) {
      if (disposed) break;
      //await Future.delayed(Duration(seconds: 1));
      await getUpdate();
    }
  }

  getUpdate() async {
    await Future.delayed(const Duration(milliseconds: 10));
    var result = await api.getUpdates();

    if (result != null) {
      if (result != "{}") {
        wpm.addFromJson(result);
        press();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    wpmTimer.cancel();
    timeTimer.cancel();
    disposed = true;
  }
}

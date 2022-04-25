import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:keyboard/pages/scene.dart';
import 'package:keyboard/themes/ThemeNotifier.dart';
import 'package:keyboard/themes/classic.dart';
import 'package:keyboard/utils/api.dart';
import 'package:keyboard/utils/routes.dart';
import 'package:keyboard/widgets/settingsWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key, this.api, this.themeNotifier}) : super();
  ApiManager? api;
  ThemeModel? themeNotifier;
  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  ApiManager api = ApiManager();
  String unit = "";
  int time = 0;
  String theme = "";

  @override
  void initState() {
    super.initState();
    api = widget.api as ApiManager;
    _getSettings();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.of(context).pushReplacement(
              FadeRoute(page: BongoScene(themeNotifier: widget.themeNotifier)));
          return true as Future<bool>;
        },
        child: Scaffold(
            body: SafeArea(
                child: SettingsList(
              sections: [
                SettingsSection(
                  title: "Server",
                  tiles: [
                    SettingsTile(
                      leading: Icon(Icons.cloud),
                      title: "ServerIP:Port",
                      subtitle: api.ip + ":" + api.port.toString(),
                      onTap: _changeServerDialog,
                    )
                  ],
                ),
                SettingsSection(
                  title: "Appearance",
                  tiles: [
                    SettingsTile(
                      leading: Icon(Icons.art_track),
                      title: "Theme",
                      subtitle: theme.toUpperCase(),
                      onTap: _changeThemeDialog,
                    ),
                  ],
                ),
                SettingsSection(
                  title: "WPM Counter",
                  tiles: [
                    SettingsTile(
                      leading: Icon(Icons.speed),
                      title: "Measure Unit",
                      subtitle: unit,
                      onTap: _changeUnitDialog,
                    ),
                    SettingsTile(
                      leading: Icon(Icons.timer),
                      title: "Count time",
                      subtitle: time.toString() + "s",
                      onTap: _changeTimeDialog,
                    ),
                  ],
                ),
              ],
            )),
            floatingActionButton: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.of(context).pushReplacement(FadeRoute(
                    page: BongoScene(themeNotifier: widget.themeNotifier)));
              },
            )));
  }

  void _changeTimeDialog() {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    List<Widget> list = [];
    SETTINGS["time"]?["options"].forEach((int value) {
      list.add(RadioListTile(
          title: Text(value.toString()),
          groupValue: time,
          value: value,
          onChanged: (val) {
            setState(() {
              _changeTime(val as int);
              Navigator.pop(context);
            });
          }));
    });
    AlertDialog alert = AlertDialog(
      title: Text('Time'),
      content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: list)),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _changeServerDialog() {
    var controller = TextEditingController();
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget applyButton = TextButton(
      child: Text("Apply"),
      onPressed: () {
        _changeIp(controller.text);
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog

    AlertDialog alert = AlertDialog(
      title: Text('Theme'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onSubmitted: (text) {
              _changeIp(text);
            },
            controller: controller..text = api.ip + ":" + api.port.toString(),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: api.ip,
            ),
          ),
        ],
      ),
      actions: [
        applyButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _changeThemeDialog() {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    List<Widget> list = [];
    SETTINGS["theme"]?["options"].forEach((String value) {
      list.add(RadioListTile(
          title: Text(value),
          groupValue: theme,
          value: value,
          onChanged: (val) {
            setState(() {
              _changeTheme(val as String);
              Navigator.pop(context);
            });
          }));
    });
    AlertDialog alert = AlertDialog(
      title: Text('Theme'),
      content: Column(mainAxisSize: MainAxisSize.min, children: list),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _changeUnitDialog() {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    List<Widget> list = [];
    SETTINGS["unit"]?["options"].forEach((String value) {
      list.add(RadioListTile(
          title: Text(value),
          groupValue: unit,
          value: value,
          onChanged: (val) {
            setState(() {
              _changeUnit(val as String);
              Navigator.pop(context);
            });
          }));
    });
    AlertDialog alert = AlertDialog(
      title: Text('Unit'),
      content: Column(mainAxisSize: MainAxisSize.min, children: list),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _changeIp(String? text) async {
    if (text != null) {
      final prefs = await SharedPreferences.getInstance();
      var s = text.split(':');
      await prefs.setString('ip', s[0]);
      await prefs.setInt('port', int.parse(s[1]));

      api.updateSettings();
      setState(() {});
    }
  }

  void _changeUnit(String? text) async {
    if (text != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('unit', text);
      unit = text;
      setState(() {});
    }
  }

  void _changeTheme(String? text) async {
    if (text != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('theme', text);
      theme = text;
      if (THEMES[text]?.appTheme != null)
        widget.themeNotifier?.setTheme = THEMES[text]?.appTheme as ThemeData;
      setState(() {});
    }
  }

  void _changeTime(int timez) async {
    final prefs = await SharedPreferences.getInstance();
    time = timez;
    prefs.setInt('time', timez);
    setState(() {});
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
        }
      }
    });
    setState(() {});
  }
}

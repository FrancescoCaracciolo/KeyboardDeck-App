import 'package:flutter/material.dart';
import 'dart:ui' as dio;

enum _SettingsTileType { simple, switchTile }

class SettingsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? leading;
  final dio.VoidCallback? onTap;
  final Function(bool value)? onToggle;
  final bool switchValue;
  final _SettingsTileType _tileType;

  const SettingsTile({
    Key? key,
    @required this.title = "",
    this.subtitle = "",
    this.leading,
    this.onTap,
  })  : _tileType = _SettingsTileType.simple,
        onToggle = null,
        switchValue = false,
        super(key: key);

  const SettingsTile.switchTile({
    Key? key,
    @required this.title = "",
    this.subtitle = "",
    this.leading,
    @required this.onToggle,
    @required this.switchValue = false,
  })  : _tileType = _SettingsTileType.switchTile,
        onTap = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return androidTile();
  }

  Widget androidTile() {
    if (_tileType == _SettingsTileType.switchTile) {
      return SwitchListTile(
        secondary: leading,
        value: switchValue,
        onChanged: onToggle,
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle) : null,
      );
    } else {
      return ListTile(
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle) : null,
        leading: leading,
        onTap: onTap,
      );
    }
  }
}

class SettingsList extends StatelessWidget {
  final List<SettingsSection> sections;

  const SettingsList({Key? key, this.sections = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          SettingsSection current = sections[index];
          SettingsSection? futureOne;
          try {
            futureOne = sections[index + 1];
          } catch (e) {}

          // Add divider if title is null
          if (futureOne != null && futureOne.title != null) {
            current.showBottomDivider = false;
            return current;
          } else {
            current.showBottomDivider = true;
            return current;
          }
        },
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  final String title;
  final List<SettingsTile> tiles;
  bool showBottomDivider = false;

  SettingsSection({
    Key? key,
    this.tiles = const [],
    this.title = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return androidSection(context);
  }

  Widget androidSection(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      title == null
          ? Container()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                title,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold),
              ),
            ),
      ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: tiles.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 1),
        itemBuilder: (BuildContext context, int index) {
          return tiles[index];
        },
      ),
    ]);
  }
}

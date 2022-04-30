import 'package:keyboard/pages/scene.dart';

import 'package:flutter/material.dart';
import 'package:keyboard/themes/ThemeNotifier.dart';
import 'package:keyboard/utils/api.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

ApiManager api = ApiManager();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeModel(
                theme: ThemeData(
              brightness: Brightness.light,
              backgroundColor: Colors.white38,
              primarySwatch: Colors.blue,
              primaryColor: Colors.blue[500],
            )),
        child: Consumer<ThemeModel>(
            builder: (context, ThemeModel themeNotifier, child) {
          return MaterialApp(
            title: 'Keyboard Deck',
            theme: themeNotifier.theme,
            home: BongoScene(
              themeNotifier: themeNotifier,
            ),
          );
        }));
  }
}

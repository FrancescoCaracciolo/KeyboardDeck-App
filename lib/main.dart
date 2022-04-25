import 'dart:async';
import 'dart:io';
import 'package:keyboard/pages/scene.dart';

import 'package:flutter/material.dart';
import 'package:keyboard/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

ApiManager api = ApiManager();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keyboard Deck',
      theme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: Colors.white38,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[500],
      ),
      home: const BongoScene(),
    );
  }
}

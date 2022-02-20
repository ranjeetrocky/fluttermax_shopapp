import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const themeSeedColors = [
  Colors.pink,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.teal,
  Colors.blueGrey,
  Colors.purple
];
var currentPlatform = TargetPlatform.android;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Color? _seedColor;
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seedColor = themeSeedColors[Random().nextInt(7)];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My shop',
      darkTheme: ThemeData(
        colorSchemeSeed: _seedColor,
        brightness: Brightness.dark,
        useMaterial3: true,
        platform: currentPlatform,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        ),
      ),
      theme: ThemeData(
        colorSchemeSeed: _seedColor,
        brightness: Brightness.light,
        useMaterial3: true,
        platform: currentPlatform,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
      ),
      body: const Center(
        child: Text('Let\'s build a shop!'),
      ),
    );
  }
}

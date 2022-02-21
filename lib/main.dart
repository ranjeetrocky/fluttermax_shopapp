import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttermax_state_management_shopapp/providers/products.dart';
import 'package:provider/provider.dart';
import './screens/products_overview_screen.dart';

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
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        title: 'My shop',
        darkTheme: ThemeData(
          colorSchemeSeed: _seedColor,
          brightness: Brightness.dark,
          useMaterial3: true,
          platform: currentPlatform,
          fontFamily: 'Lato',
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
          fontFamily: 'Lato',
          appBarTheme: const AppBarTheme(
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: ProductsOverviewScreen(),
      ),
    );
  }
}

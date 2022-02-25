import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/products.dart';
import './providers/auth.dart';
import './screens/cart_screen.dart';
import './screens/edit_product_sceen.dart';
import './screens/order_screen.dart';
import './screens/user_products_sceen.dart';
import './screens/auth_screen.dart';

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
    _seedColor = themeSeedColors[Random().nextInt(themeSeedColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders()),
        ChangeNotifierProvider.value(value: Auth()),
      ],
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
          cardTheme: const CardTheme(
            elevation: 30,
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
          cardTheme: const CardTheme(
            elevation: 30,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const AuthScreen(),
        routes: {
          CartScreen.routeName: (context) => const CartScreen(),
          OrderScreen.routeName: (context) => const OrderScreen(),
          UserProductsScreen.routName: (context) => const UserProductsScreen(),
          EditProductScreen.routeName: (context) => const EditProductScreen(),
        },
      ),
    );
  }
}

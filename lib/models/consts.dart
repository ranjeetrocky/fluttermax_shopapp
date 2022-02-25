import 'package:flutter/foundation.dart';

class Consts {
  static const double kBlur = 10;
  static const double kRadius = 15;
  static const bool kReleaseMode = bool.fromEnvironment('dart.vm.product');
  static const bool kProfileMode = bool.fromEnvironment('dart.vm.profile');
  static const bool kDebugMode = !kReleaseMode && !kProfileMode;
  static const String kFirebaseDatabaseUrl =
      'https://shop-app-6f3a8-default-rtdb.asia-southeast1.firebasedatabase.app/';
  static const String kFirebaseDatabaseScheme = 'https';
  static const String kFirebaseDatabaseHost =
      'shop-app-6f3a8-default-rtdb.asia-southeast1.firebasedatabase.app';
  static const apiKey = "AIzaSyCQJzrCENREkhVhGnLlIIpA9W8_k6qC49k";
}

kprint(Object object) {
  if (kDebugMode) {
    print(object.toString());
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';

const kDemoText = Center(
  child: Text(
    'Child will be here.',
    style: TextStyle(
      fontSize: 25,
      color: Colors.white,
      letterSpacing: 2,
    ),
    textAlign: TextAlign.center,
  ),
);
const Color kDefaultColor = Colors.transparent;
const double kColorOpacity = 0.0;

class BlurryContainer extends StatelessWidget {
  final Widget child;
  final double blur;

  final BorderRadius borderRadius;

  //final double colorOpacity;

  const BlurryContainer({
    Key? key,
    this.child = kDemoText,
    this.blur = 5,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    //this.colorOpacity = kColorOpacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: child,
      ),
    );
  }
}

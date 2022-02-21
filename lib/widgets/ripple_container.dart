import 'package:flutter/material.dart';

class RippleContainer extends StatelessWidget {
  final Widget child;
  const RippleContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: child,
    );
  }
}

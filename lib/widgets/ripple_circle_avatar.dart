import 'package:flutter/material.dart';

class RippleCircleAvatar extends StatelessWidget {
  final Widget child;
  final double radius;
  final Color backgroundColor, foregroundColor;
  const RippleCircleAvatar(
      {Key? key,
      required this.child,
      this.radius = 20,
      this.backgroundColor = Colors.transparent,
      this.foregroundColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      radius: radius,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Material(
          color: Colors.transparent,
          child: child,
        ),
      ),
    );
  }
}

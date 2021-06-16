import 'dart:ui';

import 'package:flutter/material.dart';

Widget? obj;

class Shadowed extends StatelessWidget {
  final Widget child;
  final double blurLevel, distance;
  final Color shadowColor;

  Shadowed({
    required this.child,
    this.blurLevel = 10,
    this.shadowColor = Colors.black,
    this.distance = 3,
  });

  @override
  Widget build(BuildContext context) {
    obj = child;

    return ClipRRect(
      child: Container(
        child: Stack(
          children: [
            _Shadow(
              child: child,
              blurLevel: blurLevel,
              distance: distance,
              shadowColor: shadowColor,
            ),
            child
          ],
        ),
      ),
    );
  }
}

class _Shadow extends StatelessWidget {
  final Widget child;
  final double blurLevel, distance;
  final Color shadowColor;

  _Shadow({
    required this.child,
    this.blurLevel = 10,
    this.shadowColor = Colors.black,
    this.distance = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(distance / 2),
      child: Container(
        margin: EdgeInsets.only(top: distance, left: distance),
        child: Stack(
          children: [
            ColorFiltered(
                child: child,
                colorFilter: ColorFilter.mode(shadowColor, BlendMode.srcIn)),
            BackdropFilter(
                child: Container(
                  child: ColorFiltered(
                      child: child,
                      colorFilter: ColorFilter.mode(
                          Colors.transparent, BlendMode.srcIn)),
                ),
                filter: ImageFilter.blur(
                  sigmaX: blurLevel,
                  sigmaY: blurLevel,
                ))
          ],
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';

class Blurred extends StatelessWidget {
  final double width, height, opacity, blur;
  final Widget child;
  final Color accentColor;
  final BoxDecoration boxDecoration;

  const Blurred({
    Key key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.opacity = 0.0,
    this.blur = 5,
    @required this.child,
    this.accentColor = Colors.transparent,
    this.boxDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: this.width,
          height: this.height,
          alignment: Alignment.center,
          child: this.child,
          decoration: boxDecoration,
        ),
        BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: this.blur, sigmaY: this.blur),
          child: new Container(
            width: this.width,
            height: this.height,
            decoration: this.boxDecoration.copyWith(
                  color: this.accentColor.withOpacity(this.opacity),
                ),
          ),
        ),
      ],
    );
  }
}

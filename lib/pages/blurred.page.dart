import 'package:essential_widgets/widgets/blurred.dart';
import 'package:flutter/material.dart';

class BlurredPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Blurred(
          width: 200,
          height: 200,
          opacity: .1,
          blur: 8,
          accentColor: Colors.blueGrey,
          boxDecoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: FlutterLogo(size: 100),
        ),
      ),
    );
  }
}

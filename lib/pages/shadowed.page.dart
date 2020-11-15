import 'package:essential_widgets/widgets/shadowed.dart';
import 'package:flutter/material.dart';

class ShadowedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Shadowed(
          child: Text(
            'Hola Mundo',
            style: TextStyle(fontSize: 30),
          ),
          blurLevel: 1.5,
          distance: 3,
          shadowColor: Colors.black45,
        ),
      ),
    );
  }
}

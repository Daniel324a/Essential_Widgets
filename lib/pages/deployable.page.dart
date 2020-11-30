import 'package:essential_widgets/widgets/deployable.dart';
import 'package:flutter/material.dart';

class DeployablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.centerRight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Deployable(
              child: Text(
                "holaa",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:essential_widgets/widgets/deployable.dart';
import 'package:flutter/material.dart';

class DeployablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.centerRight,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            SafeArea(
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueGrey[100],
                ),
              ),
            ),
            Deployable(
              child: Text(
                "Hello World",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

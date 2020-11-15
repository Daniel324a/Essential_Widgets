import 'package:essential_widgets/widgets/slideshow.dart';
import 'package:flutter/material.dart';

class SlideshowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Slideshow(
          slides: [
            ...List.generate(
              3,
              (i) => Container(
                alignment: Alignment.center,
                child: Text(
                  "$i",
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
                decoration: BoxDecoration(
                    color: Colors.blueGrey[400],
                    borderRadius: BorderRadius.circular(25)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

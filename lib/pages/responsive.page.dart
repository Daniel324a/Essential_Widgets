import 'package:essential_widgets/widgets/responsive.dart';
import 'package:flutter/material.dart';

class ResponsivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Responsive(
          sm: Text("Small"),
          md: Text("Medium"),
          lg: Text("Large"),
          factors: [220, 768],
        ),
      ),
    );
  }
}

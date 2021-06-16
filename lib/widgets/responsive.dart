import 'package:flutter/material.dart';

class Responsive extends StatefulWidget {
  final Widget sm, md, lg;
  final List<double> factors;

  const Responsive({
    Key? key,
    this.sm = const SizedBox(),
    this.md = const SizedBox(),
    this.lg = const SizedBox(),
    this.factors = const [],
  }) : super(key: key);

  @override
  _ResponsiveState createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final double width = constraints.maxWidth;
        final List<double> factors = widget.factors..length = 2;

        if (width <= (factors[0] ?? 200)) return widget.sm;
        if (width <= (factors[1] ?? 800)) return widget.md;

        return widget.lg;
      },
    );
  }
}

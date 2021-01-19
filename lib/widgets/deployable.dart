import 'package:flutter/material.dart';

class Deployable extends StatelessWidget {
  final bool cutInLeft;
  final Color color, iconColor;
  final Widget child;
  final Alignment alignment;
  final List<BoxShadow> shadows;

  const Deployable({
    Key key,
    this.cutInLeft = false,
    this.color = Colors.blue,
    this.iconColor,
    @required this.child,
    this.alignment = Alignment.centerRight,
    this.shadows = const [
      const BoxShadow(
        offset: Offset(0, 3),
        blurRadius: 2,
        color: Colors.black26,
      )
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _Body(
        cutInLeft: cutInLeft,
        color: iconColor,
        backgroundColor: color,
        child: child,
        shadows: shadows,
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final bool cutInLeft;
  final Color color, backgroundColor;
  final List<BoxShadow> shadows;
  final Widget child;

  const _Body({
    Key key,
    @required this.cutInLeft,
    @required this.color,
    @required this.backgroundColor,
    @required this.child,
    @required this.shadows,
  }) : super(key: key);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  IconData openIcon, closeIcon;
  bool isOpen = false;
  double bodywidth = 60;

  @override
  void initState() {
    this.openIcon = widget.cutInLeft ? Icons.chevron_right : Icons.chevron_left;
    this.closeIcon =
        widget.cutInLeft ? Icons.chevron_left : Icons.chevron_right;

    super.initState();
  }

  void toggle() {
    isOpen = !isOpen;
    setState(() => bodywidth = isOpen ? 200 : 60);
  }

  //Button Builder
  @override
  Widget build(BuildContext context) {
    List<Widget> row = [
      if (isOpen) Expanded(child: widget.child),
      Expanded(
        flex: isOpen ? 0 : 1,
        child: IconButton(
          icon: Icon(isOpen ? closeIcon : openIcon, size: 30),
          color: widget.color,
          onPressed: toggle,
        ),
      ),
    ];

    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 300),
      height: 60,
      width: bodywidth,
      decoration: BoxDecoration(
        boxShadow: [...widget.shadows],
        borderRadius: BorderRadius.horizontal(
          left: !widget.cutInLeft ? Radius.circular(999) : Radius.zero,
          right: widget.cutInLeft ? Radius.circular(999) : Radius.zero,
        ),
        color: widget.backgroundColor,
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.cutInLeft ? row.reversed : row,
      ),
    );
  }
}

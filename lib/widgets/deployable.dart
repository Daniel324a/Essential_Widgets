import 'package:flutter/material.dart';

//Global Variables
GlobalKey _key = LabeledGlobalKey("deployable");
OverlayEntry _overlayEntry;
Size buttonSize;
Offset buttonPosition;

class Deployable extends StatelessWidget {
  final bool cutInLeft;
  final Color color, iconColor;
  final Widget child;
  final Alignment alignment;

  const Deployable({
    Key key,
    this.cutInLeft = false,
    this.color = Colors.blue,
    this.iconColor,
    this.child = const SizedBox(),
    this.alignment = Alignment.centerRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: !cutInLeft ? Radius.circular(999) : Radius.zero,
          right: cutInLeft ? Radius.circular(999) : Radius.zero,
        ),
        color: color,
      ),
      child: _Body(
        cutInLeft: cutInLeft,
        color: iconColor,
        backgroundColor: color,
        child: child,
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final bool cutInLeft;
  final Color color, backgroundColor;
  final Widget child;

  const _Body({
    Key key,
    @required this.cutInLeft,
    @required this.color,
    @required this.backgroundColor,
    @required this.child,
  }) : super(key: key);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  IconData openIcon, closeIcon;
  bool isOpen = false;

  @override
  void initState() {
    this.openIcon = widget.cutInLeft ? Icons.chevron_right : Icons.chevron_left;
    this.closeIcon =
        widget.cutInLeft ? Icons.chevron_left : Icons.chevron_right;

    super.initState();
  }

  //Body Overlay Builder
  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: buttonPosition.dy,
          left: buttonPosition.dx - 180,
          height: 50,
          width: 200,
          child: Material(
              type: MaterialType.transparency,
              child: _Animated(
                child: widget.child,
                backgroundColor: widget.backgroundColor,
                color: widget.color,
                cutInLeft: widget.cutInLeft,
              )),
        );
      },
    );
  }

  //Interaction Methods
  findButton() {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  void openMenu() {
    findButton();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context).insert(_overlayEntry);
    setState(() => isOpen = !isOpen);
  }

  void closeMenu() {
    _overlayEntry.remove();
    setState(() => isOpen = !isOpen);
  }

  //Button Builder
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(isOpen ? closeIcon : openIcon, size: 30),
        color: widget.color,
        onPressed: () => isOpen ? closeMenu() : openMenu(),
      ),
    );
  }
}

class _Animated extends StatefulWidget {
  final bool cutInLeft;
  final Color color, backgroundColor;
  final Widget child;

  _Animated(
      {Key key, this.cutInLeft, this.color, this.backgroundColor, this.child})
      : super(key: key);

  @override
  __AnimatedState createState() => __AnimatedState();
}

class __AnimatedState extends State<_Animated> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> bodyWidth;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    bodyWidth = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );

    controller.addListener(() => print(bodyWidth.value));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();

    return SizeTransition(
      sizeFactor: bodyWidth,
      axis: Axis.horizontal,
      axisAlignment: 1,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(
            left: !widget.cutInLeft ? Radius.circular(999) : Radius.zero,
            right: widget.cutInLeft ? Radius.circular(999) : Radius.zero,
          ),
          color: widget.backgroundColor,
        ),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        alignment: Alignment.centerRight,
        child: widget.child,
      ),
    );
  }
}

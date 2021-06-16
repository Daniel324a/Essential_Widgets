import 'package:flutter/material.dart';

GlobalKey _key = LabeledGlobalKey("button_icon");
late OverlayEntry _overlayEntry;
late Size buttonSize;
late Offset buttonPosition;

class MultiFab extends StatefulWidget {
  final Widget? unfoldedIcon, foldedIcon, customIcon;
  final List<MultiFabItem> children;
  final ShapeBorder shape;
  final Duration animationDuration;
  final String? tooltip;
  final Color color;
  final Function? onTap;

  MultiFab({
    required this.children,
    this.foldedIcon = const Icon(Icons.apps),
    this.unfoldedIcon = const Icon(Icons.clear),
    this.shape = const CircleBorder(),
    this.animationDuration = const Duration(milliseconds: 400),
    this.color = Colors.blue,
    this.onTap,
    this.customIcon,
    this.tooltip,
  });

  @override
  _MultiFabState createState() => _MultiFabState();
}

class _MultiFabState extends State<MultiFab> {
  bool isMenuOpen = false;

  OverlayEntry _overlayEntryBuilder() => OverlayEntry(
        builder: (context) {
          return Positioned(
            top: buttonPosition.dy - (widget.children.length * 50),
            left: buttonPosition.dx,
            width: buttonSize.width,
            child: Material(
              color: Colors.transparent,
              child: Column(
                verticalDirection: VerticalDirection.up,
                children: List.generate(
                  widget.children.length,
                  (i) => _Animated(
                    index: i,
                    child: widget.children[i],
                    itemsLenght: widget.children.length,
                    animationDuration: widget.animationDuration,
                  ),
                ),
              ),
            ),
          );
        },
      );

  findButton() {
    RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  void openMenu() {
    findButton();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context)!.insert(_overlayEntry);
    setState(() => isMenuOpen = !isMenuOpen);
  }

  void closeMenu() {
    _overlayEntry.remove();
    setState(() => isMenuOpen = !isMenuOpen);
  }

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        tooltip: widget.tooltip,
        shape: widget.shape,
        backgroundColor: widget.color,
        key: _key,
        onPressed: () {},
        child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              if (widget.onTap != null) widget.onTap!();
              isMenuOpen ? closeMenu() : openMenu();
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: widget.customIcon != null
                  ? widget.customIcon
                  : isMenuOpen
                      ? widget.unfoldedIcon
                      : widget.foldedIcon,
            )),
      );
}

class _Animated extends StatefulWidget {
  final int? index, itemsLenght;
  final Widget? child;
  final Duration animationDuration;
  _Animated({
    required this.animationDuration,
    this.index,
    this.child,
    this.itemsLenght,
  });

  @override
  __AnimatedState createState() => __AnimatedState();
}

class __AnimatedState extends State<_Animated>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;
  late Animation<double> moveUp;

  @override
  void initState() {
    controller = new AnimationController(
        vsync: this, duration: widget.animationDuration);

    int index = widget.index!;
    int itemsLenght = widget.itemsLenght!;

    Interval interval = Interval(
      index * (1 / itemsLenght),
      (index + 1) * (1 / itemsLenght),
      curve: Curves.linear,
    );

    opacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: interval,
    ));

    moveUp = Tween(begin: 15.0, end: 0.0).animate(CurvedAnimation(
      parent: controller,
      curve: interval,
    ));

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
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext buildContext, Widget? child) => Opacity(
              opacity: opacity.value,
              child: Transform.translate(
                offset: Offset(0, moveUp.value),
                child: widget.child,
              ),
            ));
  }
}

class MultiFabItem extends StatelessWidget {
  final Function onPressed;
  final ShapeBorder shape;
  final Widget child;
  final Color color;
  final String? tooltip;

  const MultiFabItem({
    required this.onPressed,
    this.shape = const CircleBorder(),
    this.child = const Icon(Icons.brightness_1, color: Colors.white, size: 10),
    this.color = Colors.blue,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: tooltip,
      mini: true,
      onPressed: onPressed as void Function()?,
      child: child,
      shape: shape,
      backgroundColor: color,
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class FloatingDrawer extends StatelessWidget {
  final List<DrawerTile>? tiles;
  final Color? color;
  final Widget? separator;
  final BorderRadiusGeometry? borderRadius;

  const FloatingDrawer({
    Key? key,
    this.tiles,
    this.color,
    this.separator,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => _FloatingModel(
            tiles: this.tiles,
            color: this.color,
            borderRadius: this.borderRadius,
            separator: this.separator),
        child: FloatingDrawerBody(),
      );
}

class FloatingDrawerBody extends StatefulWidget {
  const FloatingDrawerBody({
    Key? key,
  }) : super(key: key);

  @override
  _FloatingDrawerBodyState createState() => _FloatingDrawerBodyState();
}

class _FloatingDrawerBodyState extends State<FloatingDrawerBody>
    with SingleTickerProviderStateMixin {
  List<DrawerTile>? list;

  late AnimationController _controller;
  late Animation<Offset> _transition;
  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _transition = Tween(
      begin: Offset(.5, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<_FloatingModel>();
    final bool isRoot = listEquals(model.tiles, model.rootTiles);

    _controller.reset();
    _controller.forward();

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: model.color,
        borderRadius: model.borderRadius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 3,
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: isRoot ? model.tiles!.length : model.tiles!.length + 1,
        separatorBuilder: (_, __) => model.separator!,
        itemBuilder: (_, i) => FadeTransition(
          opacity: _controller,
          child: SlideTransition(
              position: _transition,
              child: isRoot
                  ? model.safeTiles![i]
                  : i == 0
                      ? GestureDetector(
                          child: model.backTile,
                          onTap: () => model.tiles = model.safeTiles)
                      : model.tiles![i - 1]),
        ),
        padding: EdgeInsets.all(0),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final Widget? leading, trailing, child;
  final Function? onTap;
  final List<DrawerTile> children;

  const DrawerTile({
    Key? key,
    this.leading,
    this.trailing,
    this.onTap,
    required this.child,
    this.children = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: new GlobalKey(),
      child: ListTile(
        leading: this.leading,
        trailing: this.trailing,
        onTap: this.onTap as void Function()?,
        title: this.child,
      ),
    );
  }
}

class _FloatingModel extends ChangeNotifier {
  List<DrawerTile>? _tiles, _safeTiles, _rootTiles;
  DrawerTile? _backTile;
  Color? _color;
  Widget? _separator;
  BorderRadiusGeometry? _borderRadius;

  _FloatingModel({
    tiles = const [],
    color = Colors.white,
    separator = const Divider(height: 0),
    backTile = const DrawerTile(
      child: Text("Back"),
      leading: Icon(Icons.chevron_left),
    ),
    borderRadius,
  }) {
    this._tiles = tiles;
    this._safeTiles = tiles;
    this._rootTiles = tiles;
    this._backTile = backTile;
    this._color = color;
    this._borderRadius = borderRadius;
    this._separator = separator;
    this._borderRadius = borderRadius;

    createNavigation();
  }

  List<DrawerTile>? get tiles => this._tiles;
  set tiles(List<DrawerTile>? newTiles) {
    this._tiles = newTiles;
    notifyListeners();
  }

  List<DrawerTile>? get safeTiles => this._safeTiles;
  set safeTiles(List<DrawerTile>? newSafeTiles) {
    this._safeTiles = newSafeTiles;
    notifyListeners();
  }

  List<DrawerTile>? get rootTiles => this._rootTiles;
  set rootTiles(List<DrawerTile>? newRootTiles) {
    this._rootTiles = newRootTiles;
    notifyListeners();
  }

  Color? get color => this._color;
  set color(Color? newColor) {
    this._color = newColor;
    notifyListeners();
  }

  Widget? get separator => this._separator;
  set separator(Widget? newSeparator) {
    this._separator = newSeparator;
    notifyListeners();
  }

  DrawerTile? get backTile => this._backTile;
  set backWidget(DrawerTile newbackTile) {
    this._backTile = newbackTile;
    notifyListeners();
  }

  BorderRadiusGeometry? get borderRadius => this._borderRadius;
  set borderRadius(BorderRadiusGeometry? newBorderRadius) {
    this._borderRadius = newBorderRadius;
    notifyListeners();
  }

  createNavigation() {
    this._tiles!.asMap().forEach((i, DrawerTile tile) {
      if (tile.children.isEmpty) return;

      tiles!.replaceRange(i, i + 1, [prepareTile(tile)]);
    });
  }

  prepareTile(DrawerTile tile) {
    List<DrawerTile> newChildren = [];
    if (tile.children.isNotEmpty)
      tile.children.asMap().forEach((i, item) => item.children.isEmpty
          ? newChildren.add(item)
          : newChildren.add(prepareTile(item)));

    DrawerTile newTile = DrawerTile(
      key: tile.key,
      child: tile.child,
      children: newChildren,
      leading: tile.leading,
      trailing: tile.trailing,
      onTap: () {
        if (tile.onTap != null) tile.onTap!();
        tiles = newChildren;
      },
    );

    return newTile;
  }
}

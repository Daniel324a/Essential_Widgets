# Essential Widgets

A widgets library for Flutter.

## Widgets

- [Floating Drawer.](#floating-drawer)
- [Multi Fab.](#multi-fab)
- [Shadowed.](#shadowed)
- [Slideshow.](#slideshow)
- [Deployable.](#deployable)

## Third party libraries

- Provider (https://pub.dev/packages/provider).

# Usage Examples

## Floating Drawer

```dart
import 'package:essential_widgets/widgets/floatingDrawer.dart';
import 'package:flutter/material.dart';

class FloatingDrawerPage extends StatelessWidget {
  final List items = [
    DrawerTile(
      child: Text("Status: Online"),
      leading: Icon(Icons.cloud),
      trailing: Icon(
        Icons.brightness_1,
        color: Colors.green,
        size: 10,
      ),
    ),
    DrawerTile(
      child: Text("Games"),
      leading: Icon(Icons.gamepad),
      trailing: Icon(Icons.chevron_right),
      children: List.generate(2, (i) => DrawerTile(child: Text("${i + 1}"))),
    ),
    DrawerTile(
      child: Text("Friends"),
      leading: Icon(Icons.people),
      trailing: Icon(Icons.chevron_right),
      children: List.generate(5, (i) => DrawerTile(child: Text("${i + 1}"))),
    ),
    DrawerTile(
      child: Text("Exit"),
      leading: Icon(Icons.exit_to_app),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            color: Colors.transparent,
            elevation: 0,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Container(
                  width: 300,
                  child: FloatingDrawer(
                    separator: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.black12,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    tiles: [...items],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

```

<div style='display:flex; width:100%; justify-content:space-around; margin-bottom:50px'>
    <img src="https://drive.google.com/uc?export=view&id=1zeqQTNLgtlqmTazY4CDGkYowXkpD7K49"></img>
    <img src="https://drive.google.com/uc?export=view&id=1fl4drfZiQSzskUZKIlYep6R7DvnAIyR-"></img>
</div>

## Multi Fab
```dart
import 'package:essential_widgets/widgets/multiFab.dart';
import 'package:flutter/material.dart';

class MultiFabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text('Hola Mundo'),
        ),
        floatingActionButton: MultiFab(
          children: [
            ...List.generate(
                3,
                (i) => MultiFabItem(
                      onPressed: () {},
                      child: Text("$i"),
                    ))
          ],
        ));
  }
}

```
<div style='display:flex; width:100%; justify-content:space-around; margin-bottom:50px'>
    <img src="https://drive.google.com/uc?export=view&id=1bqzoO_AifNwPDZ2djn5H5SdjnSYMIgBB"></img>
    <img src="https://drive.google.com/uc?export=view&id=1jknYxL48MLZcBsjyYr0dWoECFJvQo1Iz"></img>
</div>

## Shadowed
```dart
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
```
<div style='display:flex; width:100%; justify-content:space-around; margin-bottom:50px'>
    <img src="https://drive.google.com/uc?export=view&id=1MzVx5Ns0-SZ7ieQ3oIEsjKtfqq_NCBcd"></img>
</div>

## Slideshow
```dart
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
```
<div style='display:flex; width:100%; justify-content:space-around; margin-bottom:50px'>
    <img src="https://drive.google.com/uc?export=view&id=126gPS16XAhhN0wlTsVLMarlfLmmnCi0W"></img>
</div>

## Deployable
```dart
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
```
<div style='display:flex; width:100%; justify-content:space-around; margin-bottom:50px'>
    <img src="https://drive.google.com/uc?export=view&id=1Gjs1rDPGdscr-laTT0fLVvZwb70riGe2"></img>
    <img src="https://drive.google.com/uc?export=view&id=1Oki_TiJEbR8l-9UgJKxq7ucc8usYeD3P"></img>
</div>
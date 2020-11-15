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

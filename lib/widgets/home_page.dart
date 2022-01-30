import 'package:bomber/widgets/game_grid.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BombFinda!'),
          centerTitle: true,
          leading: Image.asset('images/bomb.png'),
        ),
        body: const Center(
            child: FractionallySizedBox(
          widthFactor: 0.5,
          child: GameGrid(),
        )));
  }
}

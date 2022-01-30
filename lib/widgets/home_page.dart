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
        body: Center(
            child: FractionallySizedBox(
          widthFactor: _getWidthFactor(context),
          child: const GameGrid(),
        )));
  }

  double _getWidthFactor(BuildContext context) {
    double currentFactor =
        MediaQuery.of(context).size.height / MediaQuery.of(context).size.width;
    currentFactor = 0.8 * (currentFactor > 1.0 ? 0.9 : currentFactor);
    return currentFactor;
  }
}

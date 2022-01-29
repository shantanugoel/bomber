import 'package:flutter/material.dart';

class GameGrid extends StatelessWidget {
  const GameGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 8,
        padding: const EdgeInsets.all(4.0),
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        shrinkWrap: true,
        // childAspectRatio: 8.0 / 4.0,
        children: List.generate(
            64,
            (index) => Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.blueGrey,
                )));
  }
}

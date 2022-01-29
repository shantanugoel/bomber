import 'dart:math';

import 'package:flutter/material.dart';

class GameGrid extends StatefulWidget {
  GameGrid({Key? key}) : super(key: key);

  @override
  State<GameGrid> createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  var grid = List<int>.filled(64, -1);
  int bombLocation = Random().nextInt(63);

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
            (index) => InkWell(
                  onTap: () {
                    if (grid[index] == -1) {
                      setState(() {
                        grid[index] = _handleTileClick(index);
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: getColor(grid[index]),
                    child: grid[index] != -1
                        ? FittedBox(
                            fit: BoxFit.contain,
                            child: Text(grid[index].toString()))
                        : null,
                  ),
                )));
  }

  int _handleTileClick(int index) {
    print(bombLocation);
    print(index);
    int vertical_walk = (bombLocation ~/ 8 - index ~/ 8).abs();
    int horizontal_walk = (bombLocation % 8 - index % 8).abs();
    return vertical_walk + horizontal_walk;
  }

  Color getColor(int distance) {
    if (distance == -1) {
      return Colors.blueGrey;
    } else if (distance == 0) {
      return Colors.red;
    } else if (distance >= 1 && distance <= 3) {
      return Colors.amber;
    } else if (distance >= 4 && distance <= 6) {
      return Colors.yellow;
    } else {
      return Colors.teal.shade50;
    }
  }
}

// TODO
// Add help text
// Add sharing 
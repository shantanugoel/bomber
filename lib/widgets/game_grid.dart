import 'dart:math';

import 'package:flutter/material.dart';

class GameGrid extends StatefulWidget {
  const GameGrid({Key? key}) : super(key: key);

  @override
  State<GameGrid> createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  var grid = List<int>.filled(64, -1);
  bool _easyMode = false;
  int bombLocation =
      Random(DateTime.now().millisecondsSinceEpoch ~/ 864000000).nextInt(63);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SwitchListTile(
          title: const Text('Easy Mode?'),
          value: _easyMode,
          onChanged: (bool newValue) {
            setState(() {
              _easyMode = newValue;
            });
          }),
      _getGrid(),
    ]);
  }

  GridView _getGrid() {
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
                    child: _easyMode && grid[index] != -1
                        ? FittedBox(
                            fit: BoxFit.contain,
                            child: Text(grid[index].toString()))
                        : null,
                  ),
                )));
  }

  int _handleTileClick(int index) {
    debugPrint(index.toString());
    int verticalWalk = (bombLocation ~/ 8 - index ~/ 8).abs();
    int horizontalWalk = (bombLocation % 8 - index % 8).abs();
    return verticalWalk + horizontalWalk;
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
// Hard mode - hide numbers
// More intersting? add hints?
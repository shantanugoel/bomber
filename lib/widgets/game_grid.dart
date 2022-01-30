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
  int bombLocation = Random().nextInt(64);
  // Random(DateTime.now().millisecondsSinceEpoch ~/ 864000000).nextInt(64);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: IconButton(
                  onPressed: () {
                    showHelp();
                  },
                  icon: const Icon(Icons.help))),
          Expanded(
            child: SwitchListTile(
                title: const Text('Easy Mode?'),
                value: _easyMode,
                onChanged: (bool newValue) {
                  setState(() {
                    print(newValue);
                    _easyMode = newValue;
                  });
                }),
          ),
        ],
      ),
      _getGrid(),
    ]);
  }

  void showHelp() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Help'),
              content: const Text('''
 • Your objective is to find the bomb hiding behind a tile
 • Clicking on a tile gives you an indication of how close you are by changing color. In terms of decreasing distance -> Blue, Yellow, Orange. Red = Bomb found.
 • Switch on easy mode to also see the exact distance from the bomb location on a clicked tile
                '''),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'))
              ],
            ));
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
                    child: _easyMode && (grid[index] != -1)
                        ? FittedBox(
                            fit: BoxFit.contain,
                            child: Text(grid[index].toString()))
                        : null,
                  ),
                )));
  }

  int _handleTileClick(int index) {
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
      return Colors.orange;
    } else if (distance >= 4 && distance <= 6) {
      return Colors.yellow;
    } else {
      return Colors.teal.shade50;
    }
  }
}

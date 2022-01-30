import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
  int numClicks = 0;

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
              content: RichText(
                  text: TextSpan(text: '''
 • Your objective is to find the bomb hiding behind a tile
 • Clicking on a tile gives you an indication of how close you are by changing color. In terms of decreasing distance -> Blue, Yellow, Orange. Red = Bomb found.
 • Switch on easy mode to also see the exact distance from the bomb location on a clicked tile
 • Comments/Feedback: ''', children: [
                TextSpan(
                    text: '@shantanugoel',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap =
                          () => launch('https://twitter.com/shantanugoel'))
              ])),
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
                        numClicks += 1;
                        grid[index] = _handleTileClick(index);
                      });
                      if (index == bombLocation) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Found the Bomb!'),
                                  content: Text('Number of clicks: ' +
                                      numClicks.toString()),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('OK')),
                                    TextButton(
                                        onPressed: () => setState(() {
                                              resetState();
                                              Navigator.pop(context);
                                            }),
                                        child: const Text('Play again!'))
                                  ],
                                ));
                      }
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

  void resetState() {
    numClicks = 0;
    bombLocation = Random().nextInt(64);
    for (int i = 0; i < grid.length; ++i) {
      grid[i] = -1;
    }
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

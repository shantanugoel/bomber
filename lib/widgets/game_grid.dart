import 'package:flutter/material.dart';

class GameGrid extends StatefulWidget {
  GameGrid({Key? key}) : super(key: key);

  @override
  State<GameGrid> createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  var grid = List<int>.filled(64, 0);

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
                    if (grid[index] == 0) {
                      setState(() {
                        grid[index] = _handleTileClick(index);
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: grid[index] == 0
                        ? Colors.blueGrey
                        : Colors.teal.shade50,
                    child: grid[index] != 0
                        ? FittedBox(
                            fit: BoxFit.contain,
                            child: Text(grid[index].toString()))
                        : null,
                  ),
                )));
  }

  int _handleTileClick(int index) {
    print(index);
    return index;
  }
}

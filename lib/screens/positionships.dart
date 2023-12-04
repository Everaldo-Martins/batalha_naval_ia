import 'package:flutter/material.dart';
import '../code/ships.dart';
import 'game.dart';

class PositionShips extends StatefulWidget {
  const PositionShips({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PositionShipsState createState() => _PositionShipsState();
}

String getImageFromGrid(List<List<List<int>>> grid, int x, int y, bool isComputer) {
  int cellValue = grid[y][x][0];
  return 'assets/tab_img/tab$cellValue.png';
}

class _PositionShipsState extends State<PositionShips> {
  late Ships ship;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Batalha Naval - IA',
          style: TextStyle(
            color: Color.fromARGB(255, 216, 216, 216),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 32, 32, 32),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 216, 216, 216),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints(
                  minWidth: 300.0,
                  maxWidth: 500.0,
                  minHeight: 215.0,
                  maxHeight: 400.0,
                ),
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 39, 39, 39),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 92, 92, 92),
                              spreadRadius: 0,
                              blurRadius: 15,
                            ),
                          ],
                        ),                        
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: ship.gridX,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 0.0,
                        ),
                        itemCount: ship.gridY * ship.gridX,
                        itemBuilder: (_, i) {
                          int x = i % ship.gridX;
                          int y = i ~/ ship.gridX;
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: const Color.fromARGB(255, 12, 12, 12),
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                getImageFromGrid(ship.playerGrid, x, y, false),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: SizedBox(
                width: 80,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    backgroundColor:
                        const Color.fromARGB(255, 33, 149, 243),
                    shadowColor: const Color.fromARGB(255, 92, 92, 92),
                    elevation: 15,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Game(
                          playerName: "_nameController.text",
                          boardSize: "_selectedBoardSize",
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.bolt,
                    size: 36.0,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
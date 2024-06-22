import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';
import '/code/player.dart';
import '/code/computer.dart';
import '/code/ships.dart';
import 'winner.dart';

class Game extends StatefulWidget {
  final String playerName;
  final String boardSize;

  const Game({super.key, required this.playerName, required this.boardSize});

  @override
  // ignore: library_private_types_in_public_api
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  late int gridX, gridY;
  late Player player;
  late Ships ship;
  late Computer bot;

  static const colorPrimary = Color(0xFF202020);
  static const colorSecondary = Color(0xFFD8D8D8);
  static const colorBackground = Color(0xFF272727);
  static const colorButton = Color(0xFF2196F3);
  static const colorShadow = Color(0xFF5C5C5C);

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    initializeGame();
  }

  void initializeGame() {
    widget.boardSize == '8x12'
        ? (gridX = 12, gridY = 8)
        : (gridX = 15, gridY = 10);

    ship = Ships(gridX, gridY);
    player = Player(widget.playerName, 0, ship);
    bot = Computer(ship);
  }

  void showYourEnemy() {
    for (var y = 0; y < ship.gridY; ++y) {
      for (var x = 0; x < ship.gridX; ++x) {
        var shipId = ship.computerGrid[y][x][1];
        if (ship.computerGrid[y][x][0] == 103) {
          --ship.shipPlayer[shipId][1];
          ship.computerGrid[y][x][0] = ship.computerGrid[y][x][2];
        } else if (ship.computerGrid[y][x][0] < 100) {
          --ship.shipPlayer[shipId][1];
          ship.computerGrid[y][x][0] = 103;
        }
      }
    }
  }

  String getImageFromGrid(
      List<List<List<int>>> grid, int x, int y, bool isComputer) {
    int cellValue = grid[y][x][0];
    return 'assets/tab_img/tab${isComputer && cellValue < 100 ? 100 : cellValue}.png';
  }

  bool isSuperShot = false;

  void togglerShot(int x, int y) {
    if (isSuperShot && player.supershot > 0) {
      player.supershots(x, y);
    } else {
      player.throwBomb(x, y);
    }
    isSuperShot = false;
  }

  void updateBoard(int x, int y) {
    if (ship.lifeComputer != 0 && ship.computerGrid[y][x][0] <= 100) {
      togglerShot(x, y);
      setState(() {
        player.points = ship.calculateScore(false);
      });
      bot.gameMove();
      setState(() {});
    }

    if (ship.lifeComputer == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Winner(
            winnerName: widget.playerName,
            points: player.points,
          ),
        ),
      );
      addBanco(widget.playerName, player.points);
    } else if (ship.lifePlayer == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Winner(
            winnerName: 'Computador',
            points: ship.calculateScore(true),
          ),
        ),
      );
      showYourEnemy();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Batalha Naval - IA',
          style: TextStyle(color: colorSecondary),
        ),
        backgroundColor: colorPrimary,
        iconTheme: const IconThemeData(color: colorSecondary),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              buildGridColumn(
                widget.playerName,
                ship.playerGrid,
                false,
              ),
              buildGridColumn(
                'Computador',
                ship.computerGrid,
                true,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: SizedBox(
                    width: 80,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        backgroundColor: colorButton,
                        shadowColor: colorShadow,
                        elevation: 15,
                      ),
                      onPressed: () {
                        setState(() {
                          isSuperShot = !isSuperShot;
                        });
                      },
                      child: const Icon(
                        Icons.bolt,
                        size: 36.0,
                        color: Color(0xFFFFC107),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildGridColumn(
      String name, List<List<List<int>>> grid, bool isComputer) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: const BoxDecoration(
                  color: colorBackground,
                  boxShadow: [
                    BoxShadow(
                      color: colorShadow,
                      spreadRadius: 0,
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridX,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemCount: gridY * gridX,
                itemBuilder: (_, i) {
                  int x = i % gridX;
                  int y = i ~/ gridX;
                  return GestureDetector(
                    onTap: isComputer ? () => updateBoard(x, y) : null,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: colorPrimary),
                      ),
                      child: Center(
                        child: Image.asset(
                          getImageFromGrid(grid, x, y, isComputer),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

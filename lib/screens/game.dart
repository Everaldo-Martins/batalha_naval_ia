import 'package:batalha_naval/main.dart';
import 'package:flutter/material.dart';
import '/code/player.dart';
import '/code/computer.dart';
import '/code/ships.dart';
import 'winner.dart';

class Game extends StatefulWidget {
  final String playerName;
  final String boardSize;

  const Game({Key? key, required this.playerName, required this.boardSize})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  late int gridX, gridY;
  late Player player;
  late Ships ship;
  late Computer bot;

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    switch (widget.boardSize) {
      case '10x15':
        gridX = 15;
        gridY = 10;
        break;
      default:
        gridX = 12;
        gridY = 8;
        break;
    }
    ship = Ships(gridX, gridY);
    player = Player(widget.playerName, 0, ship);
    bot = Computer(ship);
  }

  // Mostrar a localização de todos os navios do computador que não foram descobertos
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

  void insertShipPosition() {
    //ship.playerGrid = ship.shipsLoad(false);
  }

  String getImageFromGrid(
      List<List<List<int>>> grid, int x, int y, bool isComputer) {
    int cellValue = grid[y][x][0];
    if (isComputer) {
      return cellValue < 100
          ? 'assets/tab_img/tab100.png'
          : 'assets/tab_img/tab$cellValue.png';
    } else {
      return 'assets/tab_img/tab$cellValue.png';
    }
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
    int playerScore = 0;
    int computerScore = 0;
    if (ship.lifeComputer != 0 && ship.computerGrid[y][x][0] <= 100) {
      togglerShot(x, y);
      setState(() {
        playerScore = ship
            .calculateScore(false); // Substitua pela lógica real da pontuação
        player.points = playerScore;
      });

      bot.gameMove();
      setState(() {
        computerScore = ship.calculateScore(true);
      });
    }

    if (ship.lifeComputer == 0) {
      // Grava os dados e pontos do player, e após exibe a tela venceu.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Winner(
            winnerName: widget.playerName,
            points: playerScore,
          ),
        ),
      );
      addBanco(widget.playerName, playerScore);
    } else if (ship.lifePlayer == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Winner(
            winnerName: 'Computador',
            points: computerScore,
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
          style: TextStyle(
            color: Color.fromARGB(255, 216, 216, 216),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 32, 32, 32),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 216, 216, 216),
        ),
      ),
      body: Expanded(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/bg.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 350.0,
                      maxWidth: 500.0,
                      minHeight: 400.0,
                      maxHeight: 465.0,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    color: const Color.fromARGB(100, 228, 228, 228),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridX,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 0.0,
                      ),
                      itemCount: gridY * gridX,
                      itemBuilder: (_, i) {
                        int x = i % gridX;
                        int y = i ~/ gridX;
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: const Color.fromARGB(255, 32, 32, 32),
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
                ),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 350.0,
                      maxWidth: 500.0,
                      minHeight: 400.0,
                      maxHeight: 465.0,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    color: const Color.fromARGB(100, 228, 228, 228),
                    height: double.maxFinite,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridX,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 0.0,
                      ),
                      itemCount: gridY * gridX,
                      itemBuilder: (_, i) {
                        int x = i % gridX;
                        int y = i ~/ gridX;
                        return GestureDetector(
                          onTap: () => updateBoard(x, y),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: const Color.fromARGB(255, 32, 32, 32),
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                getImageFromGrid(ship.computerGrid, x, y, true),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  width: 80,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color.fromARGB(255, 33, 149, 243),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 92, 92, 92),
                          spreadRadius: 1,
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      child: const Icon(
                        Icons.bolt,
                        size: 30.0,
                        color: Colors.amber,
                      ),
                      onPressed: () {
                        setState(() {
                          isSuperShot =
                              !isSuperShot; // Alternar entre true e false
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore
import 'dart:math';

class Ships {
  final int gridX;
  final int gridY;

  late var playerGrid;
  late var computerGrid;
  late var copy;

  // Informações sobre o jogador e o computador
  var shipPlayer = List.filled(10, [0, 0]);
  var shipComputer = List.filled(10, [0, 0]);
  // Contadores de navios
  var lifePlayer = 30, lifeComputer = 30;

  Ships(this.gridX, this.gridY) {
    copy =
        List.generate(gridY, (y) => List.generate(gridX, (x) => [100, -1, 0]));
    computerGrid = shipsLoad(true);
    playerGrid = shipsLoad(false); //List.generate(gridY, (y) => List.generate(gridX, (x) => [100, -1, 0]));
  }

  int calculateScore(bool isComputer) {
    int points = 0;
    if (!isComputer) {
      if (lifePlayer > 10) {
        points = lifePlayer * 1000;
      } else {
        points = lifePlayer * 900;
      }
    } else {
      if (lifeComputer > 10) {
        points = lifeComputer * 1000;
      } else {
        points = lifeComputer * 900;
      }
    }
    return points;
  }

  // Função para distribuir aleatoriamente os navios
  List<List<List<int>>> shipsLoad(bool isComputer) {
    // Inicializa o grid do jogo
    var grid =
        List.generate(gridY, (y) => List.generate(gridX, (x) => [100, -1, 0]));

    List<List<List<int>>> ship = [
      [
        [1, 2],
        [3, 4, 5],
        [6, 7, 8, 9],
        [10, 11, 12, 13, 14]
      ],
      [
        [15, 16],
        [17, 18, 19],
        [20, 21, 22, 23],
        [24, 25, 26, 27, 28]
      ]
    ];

    // Desenhando navios afundados (Matriz tridimencional)
    List<List<List<int>>> dead = [
      [
        [201, 202],
        [203, 204, 205],
        [206, 207, 208, 209],
        [210, 211, 212, 213, 214]
      ],
      [
        [215, 216],
        [217, 218, 219],
        [220, 221, 222, 223],
        [224, 225, 226, 227, 228]
      ]
    ];
    // Informações do navio
    var shipTypes = [
      [0, 2, 4],
      [1, 3, 3],
      [2, 4, 2],
      [3, 5, 1]
    ];

    // Controla enquanto percorre o grid
    var shipNo = 0, s;

    for (s = shipTypes.length - 1; s >= 0; --s) {
      // Percorre pra preencher todos os tipos de navios possíveis
      for (var i = 0; i < shipTypes[s][2]; ++i) {
        var d = Random().nextInt(2);
        var len = shipTypes[s][1], lx = gridX, ly = gridY, dx = 0, dy = 0;
        if (d == 0) {
          lx = gridX - len;
          dx = 1;
        } else {
          ly = gridY - len;
          dy = 1;
        }

        // Continua sorteando os lugares onde ficarão os navios de forma randômica
        var x, y, ok;
        do {
          y = Random().nextInt(ly);
          x = Random().nextInt(lx);

          var j, cx = x, cy = y;
          ok = true;

          for (j = 0; j < len; ++j) {
            if (grid[cy][cx][0] < 100) {
              ok = false;
              break;
            }

            cx += dx;
            cy += dy;
          }
        } while (!ok);

        // Percorre todos os grids de navios
        var j, cx = x, cy = y;
        for (j = 0; j < len; ++j) {
          grid[cy][cx][0] = ship[d][s][j];
          grid[cy][cx][1] = shipNo;
          grid[cy][cx][2] = dead[d][s][j];
          cx += dx;
          cy += dy;
        }

        // Verifica se está sendo desenhado o grid do computador
        if (isComputer) {
          shipComputer[shipNo] = [s, shipTypes[s][1]];
        } else {
          shipPlayer[shipNo] = [s, shipTypes[s][1]];
        }
        shipNo++;
      }
    }
    return grid;
  }

  String getShipName(int x) {
    var shipNames = [
      "Submarino",
      "Contratorpedeiros",
      "Navio-Tanque",
      "Porta-Avião"
    ];
    return shipNames[x];
  }

  // Função para verifica se o navio inteiro for atingido, troca para o navio em vermelho (navio destruido)
  void updateSinkShip(grid, shipNo, isComputer) {
    // Percorre todas as posições do grid
    for (var y = 0; y < gridY; y++) {
      for (var x = 0; x < gridX; x++) {
        // Verifica se é um navio destruido, se não continua só mostrando disparos.
        if (grid[y][x][1] == shipNo) {
          if (isComputer && shipComputer[shipNo][1] == 0) {
            grid[y][x][0] = grid[y][x][2];
          } else if (!isComputer && shipPlayer[shipNo][1] == 0) {
            grid[y][x][0] = grid[y][x][2];
          }
        }
      }
    }
  }
}

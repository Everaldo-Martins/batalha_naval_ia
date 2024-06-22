import 'dart:math';
import 'ships.dart';

class Computer {
  String computerName = "Computador";
  int shots = 0;
  int hits = 0;
  int supershot = 2;
  bool isMove = false;
  var id = 0;
  late int agreedParties;
  late Ships play;

  Computer(this.play);

  List<int> randomMove(List<List<List<int>>> board, int sizeX, int sizeY) {
    var l = Random().nextInt(sizeX);
    var c = Random().nextInt(sizeY);
    if (board[c][l][0] == 100) return [c, l];
    return randomMove(board, sizeX, sizeY);
  }

  List<int> smartMove(List<List<List<int>>> board, int sizeX, int sizeY) {
    // ignore: prefer_typing_uninitialized_variables
    var sx, sy;
    var selected = false;

    // Efetua 2 passos na procura por navio para destruir, desde que não esteja já selecionado
    for (var pass = 0; pass < 2; ++pass) {
      for (var y = 0; y < sizeY && !selected; ++y) {
        for (var x = 0; x < sizeY && !selected; ++x) {
          // Caso nessa posição já tenha sido encontrado alguma parte do navio
          if (board[y][x][0] == 103) {
            sx = x;
            sy = y;
            // Guarda as posições de cima, baixo, esquerda e direita de onde já houve uma explosão
            bool toUp = (y > 0 && board[y - 1][x][0] <= 100);
            bool toDown = (y < sizeY - 1 && board[y + 1][x][0] <= 100);
            bool toLeft = (x > 0 && board[y][x - 1][0] <= 100);
            bool toRight = (x < sizeX - 1 && board[y][x + 1][0] <= 100);

            // Se é a primeira tentativa
            if (pass == 0) {
              // Procura por duas explosões, primeiro em coluna, depois em linha              
              bool exUp = (y > 0 && board[y - 1][x][0] == 103);
              bool exDown = (y < sizeY - 1 && board[y + 1][x][0] == 103);
              bool exLeft = (x > 0 && board[y][x - 1][0] == 103);
              bool exRight = (x < sizeX - 1 && board[y][x + 1][0] == 103);

              // Verifica as posições que vão ser checadas para encontrar a nave do jogador
              // Verifica as posições que vão ser checadas para encontrar a nave do jogador
              if (toLeft && exRight) { 
                sx = x - 1; 
                selected = true; 
              }
              else if (toRight && exLeft) { 
                sx = x + 1; 
                selected = true; 
              }
              else if (toUp && exDown) {
                sy = y - 1; 
                selected = true;
              }
              else if (toDown && exUp) {
                sy = y + 1; 
                selected = true;
              }
            } else {
              // Tenta encontrar o navio por completo baseado na explosão já encontrada
              if (toLeft) {
                sx = x - 1; 
                selected = true;
              } 
              else if (toRight) {
                sx = x + 1; 
                selected = true;
              } 
              else if (toUp) {
                sy = y - 1; 
                selected = true;
              } 
              else if (toDown) {
                sy = y + 1; 
                selected = true;
              }
            }
          }
        }
      }
    }
    // Verifica se nada foi encontrado, faz a tentativa de encontrar algum navio de forma aleatória
    if (!selected) {
      return randomMove(board, sizeX, sizeY);
    }
    return [sy, sx];
  }

  void supershots(int x, int y, int sizeX, int sizeY) {
    agreedParties = 0;
    //verificação se o usuário tem tiros especiais
    for (var i = -1; i < 2; ++i) {
      for (var j = -1; j < 2; ++j) {
        var row = x + i, col = y + j;
        if (validcoordinates(col, row, sizeX, sizeY)){          
          if (play.playerGrid[col][row][0] < 100) {
            play.playerGrid[col][row][0] = 103;
            play.copy[col][row][0] = 103;
            id = play.playerGrid[col][row][1];             
            play.shipPlayer[id][1]--;            
            agreedParties++;
            play.updateSinkShip(play.playerGrid, id, false);
            play.lifePlayer--;
          } 
          else if(play.playerGrid[col][row][0] == 100) {
            play.playerGrid[col][row][0] = 102;
            play.copy[col][row][0] = 102;
          }
        }
      }
    }
    supershot--;
  }

  bool validcoordinates(int x, int y, int sizeX, int sizeY) {
    if (x >= 0 && x < sizeX && y >= 0 && y < sizeY) {
      return true;
    }
    return false;
  }

  void gameMove() {    
    late List<int> move = smartMove(play.copy, play.gridX, play.gridY);
      
    var y = move[0];
    var x = move[1];
              
    if(isMove && supershot == 2){
      supershots(x, y, play.gridX, play.gridY);  
      hits += agreedParties;       
    }
    else if(isMove && supershot == 1 && hits > play.lifeComputer){
      supershots(x, y, play.gridX, play.gridY);  
      hits += agreedParties;      
    }
    else{
      if (play.playerGrid[y][x][0] < 100) {            
        play.playerGrid[y][x][0] = 103;
        play.copy[y][x][0] = 103;
        id = play.playerGrid[y][x][1];        
        isMove = true; 
        play.shipPlayer[id][1]--;        
        hits++;
        play.updateSinkShip(play.playerGrid, id, false);
        play.lifePlayer--;
      } 
      else if (play.playerGrid[y][x][0] == 100) {        
        play.playerGrid[y][x][0] = 102;
        play.copy[y][x][0] = 102;
        isMove = false;
      }
    }
    shots++;
  }
}
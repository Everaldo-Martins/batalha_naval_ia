import 'ships.dart';
class Player {
  late String name;
  late int points;
  late Ships play;
  int supershot = 2;
  var id = 0;

  Player(this.name, this.points, this.play);

  void throwBomb(int x, int y) {
    var wh = play.computerGrid[y][x][0];
    if (wh < 100) {
      play.computerGrid[y][x][0] = 103;
      id = play.computerGrid[y][x][1];      
      play.shipComputer[id][1]--;      
      play.updateSinkShip(play.computerGrid, id, true);
      play.lifeComputer--;
    } 
    else if(wh == 100){
      play.computerGrid[y][x][0] = 102;
    }    
  }

  void supershots(int x, int y) {
    //verificação se o usuário tem tiros especiais
    for (int i = -1; i < 2; i++) {
      for (int j = -1; j < 2; j++) {
        int row = x + i, col = y + j;
        if (validcoordinates(row, col)){          
          if (play.computerGrid[col][row][0] < 100) {
            play.computerGrid[col][row][0] = 103;
            id = play.computerGrid[col][row][1];            
            play.shipComputer[id][1]--;            
            play.updateSinkShip(play.computerGrid, id, true);
            play.lifeComputer--;
          } 
          else if(play.computerGrid[col][row][0] == 100) {
            play.computerGrid[col][row][0] = 102;
          }          
        }
      }
    }
    supershot--;
  }

  bool validcoordinates(int row, int col) {
    if (row >= 0 && row < play.gridX && col >= 0 && col < play.gridY) {
      return true;
    }
    return false;
  }
}
import 'dart:math';

class Player{
  static const  x ="X";
  static const  o ="O";
  static const  empty =" ";

  // if we added numbers manually between 0 and 8  in playerX
  // and playerY it will appear on the phone's screen
  static List<int> playerX = [];
  static List<int> playerO = [];

}

extension ContainsAll on List{
  // we mad the 3rd number here an optional parameter in case we
  // want to check on 2 values only
  bool containsAll(int x, int y,  [z]) {

    if(z == null) {
      return contains(x) && contains(y);
    }
    else {
      // we removed Player.playerX. as it's not necessary
      return contains(x) && contains(y) && contains(z);
    }
  }
}

class Game{
  playGame(int index, String activePlayer){
    if(activePlayer == "X") {
      Player.playerX.add(index);
    }
    else {
      Player.playerO.add(index);
    }
  }


  String checkWinner(){
    String winner  = " ";
    if (Player.playerX.containsAll(0,1,2) ||
        Player.playerX.containsAll(3,4,5) ||
        Player.playerX.containsAll(6,7,8) ||
        Player.playerX.containsAll(0,3,6) ||
        Player.playerX.containsAll(1,4,7) ||
        Player.playerX.containsAll(2,5,8) ||
        Player.playerX.containsAll(0,4,8) ||
        Player.playerX.containsAll(2,4,6)){
          winner = "X";
    }
    else if (Player.playerO.containsAll(0,1,2) ||
        Player.playerO.containsAll(3,4,5) ||
        Player.playerO.containsAll(6,7,8) ||
        Player.playerO.containsAll(0,3,6) ||
        Player.playerO.containsAll(1,4,7) ||
        Player.playerO.containsAll(2,5,8) ||
        Player.playerO.containsAll(0,4,8) ||
        Player.playerO.containsAll(2,4,6)){
      winner = "O";
    }
    else {
      winner = " ";
    }
    return winner;
  }

  Future<void> autoPlay(activePlayer) async {
    int index = 0;
    List<int> emptyCells = [];

    for(var i = 0; i < 9; i++ ){
      if(!(Player.playerX.contains(i) || Player.playerO.contains(i))){
        emptyCells.add(i);
      }
    }
    if(Player.playerX.containsAll(0,1) && emptyCells.contains(2)){
      index = 2;
    }
    else if(Player.playerX.containsAll(3,4) && emptyCells.contains(5)){
      index = 5;
    }
    else if(Player.playerX.containsAll(6,7) && emptyCells.contains(8)){
      index = 8;
    }
    else if(Player.playerX.containsAll(0,3) && emptyCells.contains(6)){
      index = 6;
    }
    else if(Player.playerX.containsAll(1,4) && emptyCells.contains(7)){
      index = 7;
    }
    else if(Player.playerX.containsAll(2,5) && emptyCells.contains(8)){
      index = 8;
    }
    else if(Player.playerX.containsAll(0,4) && emptyCells.contains(8)){
      index = 8;
    }
    else if(Player.playerX.containsAll(2,4) && emptyCells.contains(6)){
      index = 6;
    }
    else if(Player.playerX.containsAll(0,8) && emptyCells.contains(4)){
      index = 4;
    }
    else if(Player.playerX.containsAll(2,6) && emptyCells.contains(4)){
      index = 4;
    }
    else if(Player.playerX.containsAll(0,6) && emptyCells.contains(3)){
      index = 3;
    }
    else if(Player.playerX.containsAll(1,7) && emptyCells.contains(4)){
      index = 4;
    }
    else if(Player.playerX.containsAll(2,8) && emptyCells.contains(6)){
      index = 6;
    }
    else if(Player.playerX.containsAll(0,2) && emptyCells.contains(1)){
      index = 1;
    }
    else if(Player.playerX.containsAll(3,5) && emptyCells.contains(4)){
      index = 4;
    }
    else if(Player.playerX.containsAll(6,8) && emptyCells.contains(7)){
      index = 7;
    }
    else if(Player.playerX.containsAll(4,6) && emptyCells.contains(2)){
      index = 2;
    }



    else{
      Random random = Random();
      // generating a random number with max value  8
      int randomIndex = random.nextInt(emptyCells.length);

      index = emptyCells[randomIndex];
    }


    playGame(index, activePlayer);
  }
}

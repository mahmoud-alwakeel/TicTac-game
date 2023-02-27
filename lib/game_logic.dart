class Player{
  static const  x ="X";
  static const  o ="O";
  static const  empty =" ";

  // if we added numbers manually between 0 and 8  in playerX
  // and playerY it will appear on the phone's screen
  static List<int> playerX = [];
  static List<int> playerO = [];

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

  checkWinner(){}

  autoPlay(){}
}
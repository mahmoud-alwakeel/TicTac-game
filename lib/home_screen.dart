import 'package:flutter/material.dart';
import 'package:tictac/game_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activePlayer = "X";
  bool gameOver = false;
  int turn = 0;
  String result = "";
  // object from class game in game_logic.dart
  Game game = Game();

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: MediaQuery.of(context).orientation == Orientation.portrait? Column(
          children: [
            // the return type of firstBlock is a list of widget but here
            // we want a widget not a list of widget
            // as a result the ... dots are used to extract elements of list
            ...firstBlock(),
            _expanded(context),
            ...lastBlock(),
          ],
        ) : Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...firstBlock(),
                  const SizedBox(
                    height: 40,
                  ),
                  ...lastBlock(),
                ],
              ),
            ),
            _expanded(context),
          ],
        ),
      ),
    );
  }

  List<Widget> firstBlock(){
    return [
      SwitchListTile.adaptive(
        title: const Text(
          "Turn on/off 2 player",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        value: isSwitched,
        onChanged: (bool newValue) {
          setState(() {
            isSwitched = newValue;
          });
        },
      ),
      Text(
        "it's $activePlayer turn",
        style: const TextStyle(color: Colors.white, fontSize: 32),
      ),
    ];
  }

  Expanded _expanded (BuildContext context){
    return Expanded(
      child: GridView.count(
        padding: const EdgeInsets.all(16.0),
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.0,
        children: [
          // here when i added the 3 dots (...) the error disappeared
          // the error said : The element type 'List<InkWell>' can't be assigned to the list type 'Widget
          ...List.generate(
              9,
                  (index) => InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: gameOver ? null : () => _onTap(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).shadowColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                      child: Text(
                        // as it's static we reach id directly using the class name
                        Player.playerX.contains(index)
                            ? "X"
                            : Player.playerO.contains(index)
                            ? "O"
                            : " ",
                        style: TextStyle(
                          color: Player.playerX.contains(index)
                              ? Colors.blue
                              : Colors.pink,
                          fontSize: 52,
                        ),
                      )),
                ),
              ))
        ],
      ),
    );
  }

  List<Widget> lastBlock(){
    return [
      Text(
        result,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 32,
        ),
      ),
      ElevatedButton.icon(
        onPressed: () {
          setState(() {
            Player.playerX = [];
            Player.playerO = [];
            activePlayer = "X";
            gameOver = false;
            turn = 0;
            result = " ";
          });
        },
        icon: const Icon(Icons.replay),
        label: const Text("repeat the game"),
        style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all(Theme.of(context).splashColor)),
      ),
    ];
  }

  _onTap(int index) async{

    if ((Player.playerX.isEmpty ||
        !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty ||
        !Player.playerO.contains(index))) {
      game.playGame(index, activePlayer);
      updateState();

      if(!isSwitched && !gameOver && turn != 9){
        await game.autoPlay(activePlayer);
        updateState();
      }
    }
  }

  void updateState() {
    setState(() {
      // here we are checking which player's turn to play
      // and switching between player x and o
      activePlayer = (activePlayer == "X") ? "O" : "X";
      turn++;


      String winnerPlayer = game.checkWinner();
      if(winnerPlayer != " "){
        gameOver = true;
        result = "$winnerPlayer is the winner";
      }
      else if(!gameOver && turn == 9){
        result = "It's a draw";
      }
    });
  }
}

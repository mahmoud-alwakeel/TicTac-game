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
  String result = "anything till now";
  // object from class game in game_logic.dart
  Game game = Game();

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
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
            Expanded(
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
                            onTap: gameOver? null : () => _onTap(index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).shadowColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(
                                  child: Text(
                                "X",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 52),
                              )),
                            ),
                          ))
                ],
              ),
            ),
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
          ],
        ),
      ),
    );
  }

  _onTap(int index) {
    game.playGame(index , activePlayer);
  }
}

import 'package:flutter/material.dart';
import 'package:four_in_a_row/game_manager.dart';
/// This class represents a simple 4 in a row board.
class BoardWidget extends StatefulWidget {
  const BoardWidget({Key? key}) : super(key: key);


  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {

  GameManager manager = GameManager();
  int turn = GameManager.red; // The red players is gets to play first.
  String instructionsText = "Click Start!";
  bool started = false;
  List<int> buttonsStatuses = List.generate(16, (index) => GameManager.empty); // The status of each button (empty, blue, red).
  List<Image> buttonsImages = List.generate(16, (index) => Image.asset("assets/four_in_a_row.png"));

  @override
  Widget build(BuildContext context) {
    // Create a simple four in a row game board.
    // The board is 4*4
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(instructionsText),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton( // button 0
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  _manageGame(0);
                });},
              icon: buttonsImages[0],
            ),
            IconButton( // button 1
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  _manageGame(1);
                });},
              icon: buttonsImages[1],
            ),
            IconButton( // button 2
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  _manageGame(2);
                });},
              icon: buttonsImages[2],
            ),
            IconButton( // button 3
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  _manageGame(3);
                });},
              icon: buttonsImages[3],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton( // button 4
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  _manageGame(0);
                });},
              icon: buttonsImages[4],
            ),
            IconButton( // button 5
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  _manageGame(1);
                });},
              icon: buttonsImages[5],
            ),
            IconButton( // button 6
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  _manageGame(2);
                });},
              icon: buttonsImages[6],
            ),
            IconButton( // button 7
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  _manageGame(3);
                });},
              icon: buttonsImages[7],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton( // button 8
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  _manageGame(0);
                });},
              icon: buttonsImages[8],
            ),
            IconButton( // button 9
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  _manageGame(1);
                });},
              icon: buttonsImages[9],
            ),
            IconButton( // button 10
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  _manageGame(2);
                });},
              icon: buttonsImages[10],
            ),
            IconButton( // button 11
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  _manageGame(3);
                });},
              icon: buttonsImages[11],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton( // button 12
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  _manageGame(0);
                });},
              icon: buttonsImages[12],
            ),
            IconButton( // button 13
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  _manageGame(1);
                });},
              icon: buttonsImages[13],
            ),
            IconButton( // button 14
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  _manageGame(2);
                });},
              icon: buttonsImages[14],
            ),
            IconButton( // button 15
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  _manageGame(3);
                });
              },
              icon: buttonsImages[15],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () { setState(() {
              started = true;
              manager.reset(turn, buttonsStatuses, buttonsImages); // Make sure the board is clear.
            });},
                child: const Text("Start")
            ),
            ElevatedButton(onPressed: () { setState(() {
              manager.reset(turn, buttonsStatuses, buttonsImages);
              instructionsText = "Click Start!";
            });},
                child: const Text("Reset")
            ),
          ],
        ),
      ],
    );
  }

  /// This function calls [GameManager] and handles the game.
  /// [column] is the column.
  void _manageGame(int col) {
    if (started) { // If the game stated.
      List<Object> result = manager.manageGame(col, buttonsStatuses, turn, buttonsImages);
      turn = result[0] as int;
      var checkForWin = result[1];

      if (turn == GameManager.red) {
        instructionsText = "Now it's Red's turn";
      }
      else if (turn == GameManager.blue) {
        instructionsText = "Now it's Blue's turn";
      }

      if (checkForWin == GameManager.red) { // If red won.
        instructionsText = "Red Won! Click Start to play again!";
        started = false;
      }
      else if (checkForWin == GameManager.blue) { // If blue won.
        instructionsText = "Blue Won! Click Start to play again!";
        started = false;
      }
      else if (checkForWin == GameManager.draw) { // If there is a tie.
        instructionsText = "Tie. Click Start to play again!";
        started = false;
      }
    }
  }
}
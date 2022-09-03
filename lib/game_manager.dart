import 'package:flutter/material.dart';

class GameManager {
  static const int size = 4; // The size of the board (4 * 4).
  static const int empty = 0; // Represents an empty slot.
  static const int red = -1; // Represents a slot with a red coin.
  static const int blue = 1; // Represents a slot with a blue coin.
  static const int draw = 2; // If there is a tie.

  List<List<int>> board;

  GameManager() : board = List.generate(size, (i) => List.filled(4, empty, growable: false), growable: false);

  /// This function manages the game.
  /// [col] is the column of the button.
  /// [buttonStatuses] is a list with the statuses of the buttons (see [_BoardWidgetState]).
  /// [turn] indicated which one of the players takes their turn (red or blue).
  /// [buttonsImages] contains the images of the icons.
  /// The function returns [turn] and the statues of the game (victory, tie, continues).
  List<Object> manageGame(int col, List<int> buttonsStatuses, int turn, List<Image> buttonsImages) {
    int result = _insertItem(col, turn);

    if (result != -1) { // If an item was inserted.
      turn = _changeStatusAndIcon(turn, col, buttonsStatuses, buttonsImages);
    }
    else { // No item was inserted, but we still need to change the turn.
      if (turn == red) {
        turn = blue;
      }
      else {
        turn = red;
      }
    }
    return [turn, _checkForWin()];
  }

  /// This function inserts an item to the game board only if there is an available space in the column.
  int _insertItem(int col, int turn) {
    for (int i = size - 1; i >= 0; i--) {
      if (board[i][col] == empty) { // If the item is empty
        board[i][col] = turn;
        return i;
      }
    }
    return -1; // The column is full.
  }

  /// This function changes the status and icon of the button based on the player's turn.
  /// [turn] is [red] or [blue].
  /// [col] is the column of the button.
  /// [buttonsStatuses] contains the statuses of all the buttons ([empty], [red] or [blue]).
  /// the function changes [turn] and returns it.
  int _changeStatusAndIcon(int turn, int col, List<int> buttonsStatuses, List<Image> buttonsImages) {
    int id = _getIdForCol(col);
    if (turn == red) { // If it's red's turn.
      buttonsStatuses[id] = red;
      buttonsImages[id] = Image.asset("assets/red.png");

      turn = blue;
    }
    else { // If it's blue's turn.
      buttonsStatuses[id] = blue;
      buttonsImages[id] = Image.asset("assets/blue.png");
      turn = red;
    }
    return turn;
  }

  /// This function returns [red] if red won, [blue] if blue won, [empty] if the game is still on, [draw] for draw.
  int _checkForWin() {
    int countBlue = 0;
    int countRed = 0;

    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) { // Check rows
        if (board[i][j] == blue) { // blue occurrence.
          countBlue++;
        }
        else if (board[i][j] == red) { // red occurrence.
          countRed++;
        }
      }
      if (countBlue == size) { // If the row is full with blue circles.
        return blue;
      }
      if (countRed == size) { // if the row is full with red circles.
        return red;
      }
      countRed = 0;
      countBlue = 0; // Reset the counters for the next iteration.

      for (int j = 0; j < size; j++) { // Check columns
        if (board[j][i] == blue) { // blue occurrence.
          countBlue++;
        }
        else if (board[j][i] == red) { // red occurrence.
          countRed++;
        }
      }
      if (countBlue == size) { // If the row is full with blue circles.
        return blue;
      }
      if (countRed == size) { // if the row is full with red circles.
        return red;
      }
      countRed = 0;
      countBlue = 0; // Reset the counters for the next iteration.
    }

    for (int i = 0; i < size; i++) { // Check main diagonal
      if (board[i][i] == blue) { // blue occurrence.
        countBlue++;
      }
      else if (board[i][i] == red) { // red occurrence.
        countRed++;
      }

      if (countBlue == size) { // If the row is full with blue circles.
        return blue;
      }
      if (countRed == size) { // if the row is full with red circles.
        return red;
      }
      countRed = 0;
      countBlue = 0; // Reset the counters for the next iteration.
    }

    for (int i = 0; i < size; i++) { // Check secondary diagonal
      for (int j = 0; j < size; j++) {
        if (i + j == size - 1) {
          if (board[i][j] == blue) { // blue occurrence.
            countBlue++;
          }
          else if (board[i][j] == red) { // red occurrence.
            countRed++;
          }
        }
      }

      if (countBlue == size) { // If the row is full with blue circles.
        return blue;
      }
      if (countRed == size) { // if the row is full with red circles.
        return red;
      }
      countRed = 0;
      countBlue = 0; // Reset the counters for the next iteration.
    }

    // If the code has reached this point, there is no winner yes.
    // If there is an empty slot, then the game is still on.
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (board[i][j] == empty) {
          return empty;
        }
      }
    }
    // If the code has reached this point, then the board is full, which means there is a tie.
    return draw;
  }

  /// This function returns the id of the first item that is not empty in the column.
  int _getIdForCol(int col) {
    int id = 0;
    if (col == 0) {
      for (int i = 0; i < size; i++) {
        if (board[i][col] != empty) {
          return id;
        }
        else {
          id += 4;
        }
      }
    }
    id = 1;
    if (col == 1) {
      for (int i = 0; i < size; i++) {
        if (board[i][col] != empty) {
          return id;
        }
        else {
          id += 4;
        }
      }
    }
    id = 2;
    if (col == 2) {
      for (int i = 0; i < size; i++) {
        if (board[i][col] != empty) {
          return id;
        }
        else {
          id += 4;
        }
      }
    }
    id = 3;
    if (col == 3) {
      for (int i = 0; i < size; i++) {
        if (board[i][col] != empty) {
          return id;
        }
        else {
          id += 4;
        }
      }
    }
    return -1; // Shouldn't happen if everything works as expected.
  }

  /// This function resets the game board to its initial state.
  void reset(int turn, List<int> buttonsStatuses, List<Image> buttonsImages) {
    board = List.generate(size, (i) => List.filled(4, empty, growable: false), growable: false);

    for (int i = 0; i < buttonsStatuses.length; i++) { // Reset frontend.
      buttonsStatuses[i] = GameManager.empty;
      buttonsImages[i] = Image.asset(("assets/four_in_a_row.png"));
    }
    turn = red;
  }
}
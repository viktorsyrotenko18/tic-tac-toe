import 'dart:math';

class GameController {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String winner = '';
  List<int> winningLine = [];

  void makeMove(int index, {bool vsBot = false}) {
    if (board[index] != '' || winner != '') return;

    board[index] = currentPlayer;

    checkWinner();

    if (winner == '') {
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    }

    // 🤖 хід бота
    if (vsBot && currentPlayer == 'O' && winner == '') {
      botMove();
    }
  }

  void botMove() {
    List<int> empty = [];

    for (int i = 0; i < 9; i++) {
      if (board[i] == '') empty.add(i);
    }

    if (empty.isNotEmpty) {
      int move = empty[Random().nextInt(empty.length)];
      makeMove(move, vsBot: true);
    }
  }

  void checkWinner() {
    List<List<int>> patterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var p in patterns) {
      if (board[p[0]] != '' &&
          board[p[0]] == board[p[1]] &&
          board[p[1]] == board[p[2]]) {
        winner = board[p[0]];
        winningLine = p;
      }
    }

    if (!board.contains('') && winner == '') {
      winner = 'draw';
    }
  }

  void reset() {
    board = List.filled(9, '');
    winner = '';
    winningLine = [];
    currentPlayer = 'X';
  }
}

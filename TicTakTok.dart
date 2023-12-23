import 'dart:io';

void main() {
  print("Welcome to Tic-Tac-Toe!");
  print("Player 1 (X) - Player 2 (O)");

  while (true) {
    playGame();

    print("Do you want to play again? (yes/no): ");
    String playAgain = stdin.readLineSync()?.toLowerCase() ?? "";

    if (playAgain != "yes") {
      break;
    }
  }

  print("Thanks for playing Tic-Tac-Toe!");
}

void playGame() {
  List<String> board = List.generate(9, (index) => (index + 1).toString());
  int currentPlayer = 1;

  while (true) {
    displayBoard(board);

    int move;
    do {
      print("Player $currentPlayer, please enter the number of the square where yo want to place your ${currentPlayer == 1 ? 'X' : 'O'} ");
      String? input = stdin.readLineSync();
      move = int.tryParse(input ?? '') ?? 0;
    } while (!isValidMove(move, board));

    board[move - 1] = currentPlayer == 1 ? 'X' : 'O';

    if (checkForWinner(board)) {
      displayBoard(board);
      print("Player $currentPlayer wins!");
      break;
    }

    if (board.every((cell) => cell == 'X' || cell == 'O')) {
      displayBoard(board);
      print("It's a draw!");
      break;
    }

    currentPlayer = 3 - currentPlayer;
  }
}
void displayBoard(List<String> board) {
  print(" ${board[0]} | ${board[1]} | ${board[2]} ");
  print("-----------");
  print(" ${board[3]} | ${board[4]} | ${board[5]} ");
  print("-----------");
  print(" ${board[6]} | ${board[7]} | ${board[8]} ");
}

bool isValidMove(int move, List<String> board) {
  return move >= 1 && move <= 9 && board[move - 1] != 'X' && board[move - 1] != 'O';
}

bool checkForWinner(List<String> board) {
  // Check rows, columns, and diagonals
  for (var i = 0; i < 3; i++) {
    if (board[i] == board[i + 3] && board[i + 3] == board[i + 6]) {
      return true; // Check columns
    }
    if (board[i * 3] == board[i * 3 + 1] && board[i * 3 + 1] == board[i * 3 + 2]) {
      return true; // Check rows
    }
  }

  if (board[0] == board[4] && board[4] == board[8]) {
    return true; // Check main diagonal
  }
  if (board[2] == board[4] && board[4] == board[6]) {
    return true; // Check anti-diagonal
  }

  return false;
}

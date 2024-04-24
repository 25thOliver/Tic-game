import 'dart:core';
import 'dart:io';

bool winner = false;
bool isXturn = true;

List<String> cordinates = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
List<String> combinations = ['012', '048', '036', '147', '246', '258', '345', '678'];

void main()
{
  generateBoard();

  getnextCharacter();

}

int movementCount = 0;

bool checkCombination(String combination, String checkFor)
{
  List<int> numbers = combination.split('').map((item)
  {
    return int.parse(item);
  }).toList();

  bool match = false;

  for (final item in numbers)
  {
    if (cordinates[item] == checkFor)
    {
      match = true;
    }
    else
    {
      match = false;
      break;
    }
  }
  return match;
}

void checkWinner(player)
{
  for (final item in combinations)
  {
    bool combinationValidity = checkCombination(item, player);

    if (combinationValidity == true)
    {
      print('$player WON!');
      winner = true;
      break;
    }
  }
}

// Get input to check winners
void getnextCharacter()
{
  print('Choose number for ${isXturn == true ? "X" : "O"}');
  int number = int.parse(stdin.readLineSync()!);
 
  if (number >= 1 && number <= 9 && cordinates[number - 1] == number.toString())
  {
    cordinates[number - 1] = isXturn ? 'X' : 'O';

    isXturn = !isXturn;

    movementCount++;

    if (movementCount == 9)
    {
      winner = true;
      print('DRAW!');
      generateBoard();
      return;
    }
    else 
    {
      clearScreen();
      generateBoard();
    }

    checkWinner('X');
    if (!winner)
    {
      checkWinner('O');
    }

    if(!winner)
    {
      getnextCharacter();
    }
    else
    {
      print('Invalid move! Please choose a valid nuber.');
      getnextCharacter();
    }
  }
}

void clearScreen()
{
  if (Platform.isWindows)
  {
    print(Process.runSync("cls", [], runInShell: true).stdout);
  }
  else
  {
    print(Process.runSync("clear", [], runInShell: true).stdout);
  }
}

void generateBoard()
{
  print(' | | ');
  print(' ${cordinates[0]} | ${cordinates[1]} | ${cordinates[2]}');
  print('___|___|___');
  print(' | | ');
  print(' ${cordinates[3]} | ${cordinates[4]} | ${cordinates[5]}');
  print('___|___|___');
  print(' | | ');
  print(' ${cordinates[6]} | ${cordinates[7]} | ${cordinates[8]}');
  print(' | | ');
}

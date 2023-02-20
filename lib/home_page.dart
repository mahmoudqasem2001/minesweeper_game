import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:minisweeper_game/bomb.dart';
import 'package:minisweeper_game/number_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //------ Gradient Colors--------//
  final Shader gradText = const LinearGradient(
    colors: <Color>[Colors.purple, Colors.red],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 170.0, 80.0));

  // grid variable
  int numberOfSquares = 12 * 9;
  int numberInEachRow = 9;
  int numberOfBombs = 15;

  // [number of bombs around , revealed = true / false]
  var squareStatus = [];

// bomb location
  final List<int> bombLocation = [];
  bool bombsRevealed = false;

//-------------- Timer Module---------------
  int _timeElapsed = 0;
  bool _isRunning = false;
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (_isRunning == false) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _timeElapsed++;
        });
      });
      _isRunning = true;
    }
  }

  void _stopTimer() {
    _timer.cancel();
  }

  void _resetTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    setState(() {
      _timeElapsed = 0;
    });
  }

  //------------end timer module------------//
  void randomBombs() {
    for (var i = 0; i < numberOfBombs; i++) {
      bombLocation.add(Random().nextInt(numberOfSquares));
    }
  }

  void restartGame() {
    setState(() {
      //clear all past data
      bombsRevealed = false;
      squareStatus.clear();
      bombLocation.clear();
      //initialize new square status
      for (var i = 0; i < numberOfSquares; i++) {
        squareStatus.add([0, false]);
      }
      randomBombs();
      scanBombs();
    });
    _resetTimer();
    _isRunning = false;
  }

  @override
  void initState() {
    super.initState();
    // initially, each square has 0 bobs around, and is not revealed
    for (int i = 0; i < numberOfSquares; i++) {
      squareStatus.add([0, false]);
    }
    randomBombs();
    scanBombs();
  }

  void revealBoxNumbers(int index) {
    // reveal current box if it is a number : 1,2,3 etc
    if (squareStatus[index][0] != 0) {
      setState(() {
        squareStatus[index][1] = true;
      });
    }
    // if current box is 0
    else if (squareStatus[index][0] == 0) {
      setState(() {
        // reveal current box, and the / surrounding boxes, unless you're on a wall
        squareStatus[index][1] = true;
        // if the current box is the first index in grid
        // reveal left box (unless we are currently on the left wall)
        if (index % numberInEachRow != 0 && index != 0) {
          // if next box is not revealed yet and it is a 0, then secure
          if (squareStatus[index - 1][0] == 0 &&
              squareStatus[index - 1][1] == false) {
            revealBoxNumbers(index - 1);
          }
          // reveal left box
          squareStatus[index - 1][1] = true;
        } else {
          squareStatus[index][1] = true;
        }

        // reveal top left box (unless we are currently on the left wall or the top row)
        if (index % numberInEachRow != 0 && index > numberInEachRow) {
          // if next box is not revealed yet and it is a 0, then secure
          if (squareStatus[index - numberInEachRow - 1][0] == 0 &&
              squareStatus[index - numberInEachRow - 1][1] == false) {
            revealBoxNumbers(index - 1 - numberInEachRow);
          }
          squareStatus[index - numberInEachRow - 1][1] = true;
        }

        // reveal top  box (unless we are currently on  the top row)
        if (index > numberInEachRow) {
          // if next box is not revealed yet and it is a 0, then secure
          if (squareStatus[index - numberInEachRow][0] == 0 &&
              squareStatus[index - numberInEachRow][1] == false) {
            revealBoxNumbers(index - numberInEachRow);
          }
          squareStatus[index - numberInEachRow][1] = true;
        }

        // reveal top right box (unless we are currently on the right wall or the top row)
        if (index % numberInEachRow != numberInEachRow - 1 &&
            index > numberInEachRow) {
          // if next box is not revealed yet and it is a 0, then secure
          if (squareStatus[index - numberInEachRow + 1][0] == 0 &&
              squareStatus[index - numberInEachRow + 1][1] == false) {
            revealBoxNumbers(index + 1 - numberInEachRow);
          }
          squareStatus[index + 1 - numberInEachRow][1] = true;
        }

        // reveal right box (unless we are currently on the right wall)
        if (index % numberInEachRow != numberInEachRow - 1) {
          // if next box is not revealed yet and it is a 0, then secure
          if (squareStatus[index + 1][0] == 0 &&
              squareStatus[index + 1][1] == false) {
            revealBoxNumbers(index + 1);
          }
          squareStatus[index + 1][1] = true;
        }

        // reveal buttom right box (unless we are currently on the right wall or the buttom row)
        if (index % numberInEachRow != numberInEachRow - 1 &&
            index < numberOfSquares - numberInEachRow) {
          // if next box is not revealed yet and it is a 0, then secure
          if (squareStatus[index + 1 + numberInEachRow][0] == 0 &&
              squareStatus[index + 1 + numberInEachRow][1] == false) {
            revealBoxNumbers(index + 1 + numberInEachRow);
          }
          squareStatus[index + 1 + numberInEachRow][1] = true;
        }

        // reveal buttom box (unless we are currently on the buttom row)
        if (index < numberOfSquares - numberInEachRow) {
          // if next box is not revealed yet and it is a 0, then secure
          if (squareStatus[index + numberInEachRow][0] == 0 &&
              squareStatus[index + numberInEachRow][1] == false) {
            revealBoxNumbers(index + numberInEachRow);
          }
          squareStatus[index + numberInEachRow][1] = true;
        }

        // reveal buttom left box (unless we are currently on the buttom row or the left culomn)
        if (index % numberInEachRow != 0 &&
            index < numberOfSquares - numberInEachRow) {
          // if next box is not revealed yet and it is a 0, then secure
          if (squareStatus[index + numberInEachRow - 1][0] == 0 &&
              squareStatus[index + numberInEachRow - 1][1] == false) {
            revealBoxNumbers(index - 1 + numberInEachRow);
          }
          squareStatus[index - 1 + numberInEachRow][1] = true;
        }
      });
    }
  }

  void scanBombs() {
    for (int i = 0; i < numberOfSquares; i++) {
      // there are no bombs around initially
      int numberOfBombsAround = 0;

      /*
      check each square to see if it has bombs surrounding it, 
      there are 8 surrounding boxes to check 
      
       */

      // check square to the left, unless it is in the first column
      if (bombLocation.contains(i - 1) && i % numberInEachRow != 0) {
        numberOfBombsAround++;
      }

      // check square to the top left , unless it is in the first column or first row
      if (bombLocation.contains(i - 1 - numberInEachRow) &&
          i % numberInEachRow != 0 &&
          i >= numberInEachRow) {
        numberOfBombsAround++;
      }
      // check square to the top, unless it is in the first row
      if (bombLocation.contains(i - numberInEachRow) && i >= numberInEachRow) {
        numberOfBombsAround++;
      }
      // check square to the top right , unless it is in the last column or first row
      if (bombLocation.contains(i - numberInEachRow + 1) &&
          i >= numberInEachRow &&
          (i % numberInEachRow) != (numberInEachRow - 1)) {
        numberOfBombsAround++;
      }

      // check square to the right, unless it is in the last column
      if (bombLocation.contains(i + 1) &&
          (i % numberInEachRow) != (numberInEachRow - 1)) {
        numberOfBombsAround++;
      }

      // check square to the buttom right, unless it is in the last row or last column
      if (bombLocation.contains(i + numberInEachRow + 1) &&
          (i % numberInEachRow) != (numberInEachRow - 1) &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombsAround++;
      }

      // check square to the buttom, unless it is in the last row
      if (bombLocation.contains(i + numberInEachRow) &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombsAround++;
      }

      // check square to the buttom left, unless it is in the last row or first column
      if (bombLocation.contains(i + numberInEachRow - 1) &&
          i < numberOfSquares - numberInEachRow &&
          i % numberInEachRow != 0) {
        numberOfBombsAround++;
      }

      // add total number of bombs around to square starus
      setState(() {
        squareStatus[i][0] = numberOfBombsAround;
      });
    }
  }

  void playerLost() {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: Colors.blue.shade200,
            title: const Center(
              child: Text(
                'YOU LOST!',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'YOUR TIME : $_timeElapsed',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      restartGame();
                      _resetTimer();
                      _isRunning = false;
                      Navigator.pop(context);
                    },
                    color: Colors.green.shade200,
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          );
        }));
  }

  void playerWon() {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: Colors.blue.shade200,
            title: Center(
              child: Column(
                children: const [
                  Text(
                    'YOU WON',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.sentiment_very_satisfied_outlined,
                    color: Colors.green,
                  )
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'YOUR TIME : $_timeElapsed',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      restartGame();
                      _resetTimer();
                      _isRunning = false;
                      Navigator.pop(context);
                    },
                    color: Colors.green.shade200,
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          );
        }));
  }

  void checkWinner() {
    //check how many boxes yet to reveal
    int unrevealedBoxes = 0;
    for (var i = 0; i < numberOfSquares; i++) {
      if (squareStatus[i][1] == false) {
        unrevealedBoxes++;
      }
    }
    //if this number is the same as the number of bombs, then player wins!
    if (unrevealedBoxes == bombLocation.length) {
      playerWon();
      _stopTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Column(
        children: [
          //game state and menu
          Container(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            height: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // display number of bombs
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      bombLocation.length.toString(),
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    const Text('B O M B'),
                  ],
                ),

                //button  to refresh the game
                GestureDetector(
                  onTap: restartGame,
                  child: Card(
                    color: Colors.green[400],
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),

                //display time taken
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _timeElapsed.toString(),
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    const Text('T I M E'),
                  ],
                ),
              ],
            ),
          ),
          //grid

          Expanded(
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: numberOfSquares,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: numberInEachRow),
                itemBuilder: (context, index) {
                  if (bombLocation.contains(index)) {
                    return MyBomb(
                      revealed: bombsRevealed,
                      function: () {
                        setState(() {
                          bombsRevealed = true;
                        });
                        playerLost();
                        //player tapped the bomb , so player loses
                        _stopTimer();
                      },
                    );
                  } else {
                    return MyNumberBox(
                      child: squareStatus[index][0],
                      revealed: squareStatus[index][1],
                      function: () {
                        //reveal current box
                        revealBoxNumbers(index);
                        checkWinner();
                        _startTimer();
                      },
                    );
                  }
                }),
          ),

          //branding

          const Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Text('C R E A T E D      B Y     ENG . M A H M O U D '),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Game extends StatefulWidget {
  final String word;
  final bool isEasy;

  Game({required this.word, required this.isEasy, Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  String userInput = '';
  int move = 0;
  bool isTimeOver = false;
  Timer? _timer;
  int _start = 60;

  Color Color3 = Color.fromARGB(255, 18, 40, 70);

  List<String> letters = [];
  List<String> alphabets = [
    "Q",
    "W",
    "E",
    "R",
    "T",
    "Y",
    "U",
    "I",
    "O",
    "P",
    "A",
    "S",
    "D",
    "F",
    "G",
    "H",
    "J",
    "K",
    "L",
    "Z",
    "X",
    "C",
    "V",
    "B",
    "N",
    "M",
  ];

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          isTimeOver = true;
          _showGameOverDialog();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    letters = widget.word.toUpperCase().split('');
    if (!widget.isEasy) {
      startTimer();
    } else {
      _start = 0;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('Time is up!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _checkWord() {
    if (userInput == widget.word.toUpperCase()) {
      _showWinDialog();
    } else {
      setState(() {
        move++;
        if (move == 9) {
          _showGameOverDialog();
        }
      });
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('You Won!'),
          content: Text('Congratulations!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return SafeArea(
      /*backgroundColor: Colors.purple,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 44, 3, 44),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 60),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!widget.isEasy) Icon(Icons.alarm),
                Text(
                  '$_start',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0),
            child: Text(
              'Moves: $move/9',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
      body:*/
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        LayoutBuilder(
          builder: (context, constraints) => Container(
            height: 70,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.word.length, (index) {
                  return Container(
                    width: 30,
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color3.withOpacity(0.2), width: 1),
                      color: userInput.length > index
                          ? Colors.white
                          : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        userInput.length > index ? userInput[index] : '',
                        style: TextStyle(
                          color: Color3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
        Container(
          width: w,
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 7,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            padding: EdgeInsets.all(10.0),
            children: alphabets.map((e) {
              return TextButton(
                onPressed: () {
                  setState(() {
                    if (userInput.length < letters.length) {
                      userInput += e;
                    }
                    if (userInput.length == letters.length) {
                      _checkWord();
                    }
                  });
                },
                child: Text(
                  e,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15, color: Colors.white, fontFamily: "Aller"),
                ),
                style: TextButton.styleFrom(
                    backgroundColor: Color3.withOpacity(0.5),
                    fixedSize: Size(25, 25),
                    elevation: 1,
                    shadowColor: Colors.blueAccent.shade100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
              );
            }).toList(),
          ),
        ),
      ]),
      /*    floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            userInput = '';
          });
        },
        backgroundColor: Colors.amber,
        child: Icon(Icons.refresh),
      ),*/
    );
  }
}

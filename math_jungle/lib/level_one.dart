import 'dart:async';
import 'package:flutter/material.dart';
import 'package:math_jungle/Buttons/my_button.dart';
import 'package:math_jungle/Buttons/result_message.dart';
import 'package:math_jungle/nav_page.dart';
import 'dart:math';
import 'package:math_jungle/useables.dart';
import 'package:audioplayers/audioplayers.dart';

class LevelOnePage extends StatefulWidget {
  const LevelOnePage({super.key});

  @override
  State<LevelOnePage> createState() => _LevelOneState();
}

class _LevelOneState extends State<LevelOnePage> {
  late Timer time;
  int tick = 0;
  List<String> numberPad = [
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    'DEL',
    '1',
    '2',
    '3',
    '=',
    '0',
  ];
  int numberA = 1;
  int numberB = 1;
  String operator = "+";
  String userAnswer = '';
  int questionNumber = 0;

  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    time = Timer.periodic(const Duration(seconds: 1), updateTick);
  }

  void updateTick(Timer timer) {
    if (!mounted) return;
    setState(() {
      tick++;
    });
    if (tick == 20) {
      time.cancel();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return const StartPage();
      }));
    }
  }

  bool isAnswerCorrect(String op, int numberA, int numberB, double answer) {
    switch (op) {
      case "+":
        return answer == numberA + numberB;
      case '-':
        return answer == numberA - numberB;
      case '/':
        return answer == numberA / numberB;
      case '*':
        return answer == numberA * numberB;
      default:
        return false;
    }
  }

  Future<void> playCongrats() async {
    await player.setSource(AssetSource("sounds/Congrats.mp3"));
    await player.setVolume(0.5);
    await player.resume();
  }

  Future<void> playKeepOn() async {
    await player.setSource(AssetSource("sounds/wompWomp.mp3"));
    await player.setVolume(0.5);
    await player.resume();
  }

  void goToMainPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const StartPage()));
  }

  void goBackToQuestion() {
    Navigator.of(context).pop();
  }

  void goToNextQuestion() {
    Navigator.of(context).pop();
    setState(() {
      userAnswer = '';
    });
    newQuestion();
  }

  void checkResult(String op, int numberA, int numberB, double answer) {
    if (isAnswerCorrect(op, numberA, numberB, answer)) {
      if (questionNumber < 10) {
        questionNumber++;
        tick = 0;
        playCongrats();
        showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: 'Correct',
              onTap: goToNextQuestion,
              icon: Icons.arrow_forward,
            );
          },
        );
      }

      // This block should not be nested inside the previous if statement.
      if (questionNumber == 10) {
        showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: 'Congratulations',
              onTap: goToMainPage,
              icon: Icons.arrow_forward_sharp,
            );
          },
        );
      }
    } else {
      playKeepOn();
      showDialog(
        context: context,
        builder: (context) {
          return ResultMessage(
            message: 'Have Another Go',
            onTap: goBackToQuestion,
            icon: Icons.rotate_left,
          );
        },
      );
    }
  }

  String createRandomSymbol() {
    var symbols = ['+', '-', '*', '/'];
    symbols.shuffle();
    return symbols.first;
  }

  void fixNegatives() {
    if (operator == "-" && numberA < numberB) {
      int temp = numberB;
      numberB = numberA;
      numberA = temp;
    }

    // Ensure both numbers are non-zero
    if (numberA == 0) numberA = 1;
    if (numberB == 0) numberB = 1;
  }

  void fixDivision() {
    while (operator == '/' && (numberB == 0 || numberA % numberB != 0)) {
      numberA = Random().nextInt(12) + 1; // Ensuring numberA is at least 1
      numberB = Random().nextInt(12) + 1; // Ensuring numberB is at least 1
    }
  }

  void newQuestion() {
    var randomNumber = Random();
    setState(() {
      numberA = randomNumber.nextInt(12) + 1; // Ensuring numberA is at least 1
      numberB = randomNumber.nextInt(12) + 1; // Ensuring numberB is at least 1
      operator = createRandomSymbol();
      fixNegatives();
      fixDivision();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(25),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Level One:  $tick",
                      textAlign: TextAlign.right,
                      style: timerAndTitle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        questionNumber.toString(),
                        textAlign: TextAlign.right,
                        style: numberQuestion,
                      ),
                      Text(
                        "/10",
                        style: numberQuestion,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              '$numberA $operator $numberB = ',
              style: const TextStyle(fontSize: 32, color: Colors.purpleAccent),
            ),
          ),
          Container(
            height: 55,
            width: 110,
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(userAnswer, style: basicTextStyle),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                itemCount: numberPad.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  return MyButton(
                    child: numberPad[index],
                    onTap: () {
                      var button = numberPad[index];
                      setState(() {
                        if (button == '=') {
                          checkResult(operator, numberA, numberB,
                              double.parse(userAnswer));
                        } else if (button == 'C') {
                          userAnswer = '';
                        } else if (button == 'DEL') {
                          if (userAnswer.isNotEmpty) {
                            userAnswer =
                                userAnswer.substring(0, userAnswer.length - 1);
                          }
                        } else if (userAnswer.length < 3) {
                          userAnswer += button;
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

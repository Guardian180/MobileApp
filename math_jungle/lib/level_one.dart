import 'dart:async';
import 'package:flutter/material.dart';
import 'package:math_jungle/Buttons/my_button.dart';
import 'package:math_jungle/Buttons/result_message.dart';
import 'package:math_jungle/nav_page.dart';
import 'dart:math';
import 'package:math_jungle/useables.dart';
// ignore: unused_import
import 'package:audioplayers/audioplayers.dart';

// Create Random Operators
class LevelOnePage extends StatefulWidget {
  const LevelOnePage({super.key});

  @override
  State<LevelOnePage> createState() => _LevelOneState();
}

class _LevelOneState extends State<LevelOnePage> {
  late Timer time;
  int tick = 0;
  @override
  void initState() {
    super.initState();
    time = Timer.periodic(const Duration(seconds: 1), updateTick);
  }

  void updateTick(Timer timer) {
    setState(() {
      tick++;
      if (tick == 15) {
        time.cancel();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return const StartPage();
        }));
      }
    });
  }

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
  // Question
  int numberA = 1;
  int numberB = 1;
  String operator = "+";
  // Answer
  String userAnswer = '';
  // Question Tracker
  int questionNumber = 0;

  // On Button Tapped

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

  final player = AudioPlayer();
  Future<void> playCongrats() async {
    await player.setSource(AssetSource(
      "sounds/Congrats.mp3",
    ));
    await player.setVolume(0.5);
    await player.resume();
  }

//check if user is right
  void checkResult(String op, int numberA, int numberB, double answer) {
    if (isAnswerCorrect(op, numberA, numberB, answer) && questionNumber < 10) {
      questionNumber++;
      tick = 0;
      playCongrats();
      showDialog(
        context: context,
        builder: (context) {
          return ResultMessage(
            message: 'Correct  ',
            onTap: goToNextQuestion,
            icon: Icons.arrow_forward,
          );
        },
      );
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
                message: 'Sorry Try Again',
                onTap: goBackToQuestion,
                icon: Icons.rotate_left);
          });
    }
  }

  // ignore: avoid_print
  void buttonTapped(String button) {
    setState(
      () {
        if (button == '=') {
          //Check if user is correct
          checkResult(operator, numberA, numberB, double.parse(userAnswer));
        } else if (button == 'C') {
          // CLears answer input
          userAnswer = '';
        } else if (button == 'DEL') {
          // Deletes the last user input
          if (userAnswer.isNotEmpty) {
            userAnswer = userAnswer.substring(0, userAnswer.length - 1);
          }
          // Caps at 3 Numbers
        } else if (userAnswer.length < 3) {
          userAnswer += button;
        }
      },
    );
  }

// Create Random Number
  var randomNumber = Random();
  // Create Random Symbol
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
  }

  void fixDevision() {
    if (numberA % numberB != 0 || numberB == 0) {
      goToNextQuestion();
    } else {
      print("Devision is valid");
    }
  }

  // GoToNextQuestion
  void goToNextQuestion() {
    //Dimiss
    Navigator.of(context).pop();
    //Value Reset
    setState(() {
      userAnswer = '';
    });

    //New Question
    numberA = randomNumber.nextInt(12);
    numberB = randomNumber.nextInt(12);
    operator = createRandomSymbol();
    fixNegatives();
    fixDevision();
  }

  //Fix - Questions

  //goBackToQuestion
  void goBackToQuestion() {
    Navigator.of(context).pop();
  }

// goToMainPage
  void goToMainPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const StartPage()));
  }

// End of Level
  void endOfLevel() {
    if (questionNumber == 10) {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
                message: 'Congratulation',
                onTap: goToMainPage,
                icon: Icons.arrow_forward_sharp);
          });
    }
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
                      padding: const EdgeInsets.all(
                        25,
                      ),
                      alignment: Alignment.centerRight,
                      child: Text("Level One:  " + tick.toString(),
                          textAlign: TextAlign.right, style: timerAndTitle),
                    ),
                  ]),
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
                  ))),
          Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.bottomCenter,
            child:
                //Question
                Text(
              // ignore: prefer_interpolation_to_compose_strings
              numberA.toString() + operator + numberB.toString() + ' = ',
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
                    onTap: () => buttonTapped(numberPad[index]),
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

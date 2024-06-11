import 'package:flutter/material.dart';
import 'package:math_jungle/level_one.dart';
import 'package:math_jungle/level_two.dart';
import 'package:math_jungle/level_zero.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int option = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Background1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Welcome to the Jungle",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 50,
                  fontFamily: "Itim",
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: RotatedBox(
                quarterTurns: 1,
                child: Image.asset("assets/Tiger.png"),
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CommonNavigationButton(
                    label: 'Level Zero',
                    onTap: LevelZeroPage /* Page */ (),
                  ),
                  CommonNavigationButton(
                    label: 'Level One',
                    onTap: LevelOnePage(),
                  ),
                  CommonNavigationButton(
                    label: 'Level Two',
                    onTap: LevelTwoPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommonNavigationButton extends StatelessWidget {
  const CommonNavigationButton(
      {required this.label, required this.onTap, super.key});

  final String label;

  /// Only return a Widget which has a `Scaffold` since this is with `Navigator.of(context).push`
  /// - APEALED
  final Widget onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => onTap));
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          shape: const BeveledRectangleBorder(),
          fixedSize: const Size(100, 100)),
      child: Text(label),
    );
  }
}

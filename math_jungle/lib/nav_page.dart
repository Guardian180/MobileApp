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
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset(
                "assets/Background1.jpg",
              ),
            ),
          ),
          Expanded(
            child: Positioned(
              left: -50,
              top: 135,
              child: Transform.rotate(
                  angle: 90 * 3.14 / 180,
                  child: Image.asset("assets/Tiger.png")),
            ),
          ),
          const Column(
            children: [
              Text(
                "Welcome to the Jungle",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 50,
                    fontFamily: "Itim",
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CommonNavigationButton(
                      label: 'Level Zero',
                      onTap: (context) => const LevelZeroPage /* Page */ (),
                    ),
                    CommonNavigationButton(
                      label: 'Level One',
                      onTap: (context) => const LevelOnePage(),
                    ),
                    CommonNavigationButton(
                        label: 'Level Two',
                        onTap: (context) => const LevelTwoPage()),
                  ],
                ),
              ),
            ],
          ),
        ],
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
  final WidgetBuilder onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: onTap));
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

import 'package:flutter/material.dart';
import 'package:math_jungle/nav_page.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          body: Stack(
            children: [
              //Contains Background makes it so it fits the length and Width of the user screen
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
              // This contains my text at the Top start is top,
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Start Text : The text includes some styling that changes the fontSize, font and colour.
                  Text(
                    "Welcome To the Math Jungle",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: "Itim",
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              //Tiger Image : This contains my TIGER Within a column, end is bottom
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Center(child: Image.asset("assets/Tiger.png"))],
              ),
              // START Button : These lines initalises my buttons functionality, this means that when the button is used it takes you to the nav page
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StartPage()));
                  },
                  // Button Style : This styles my buttons size, background and text colour
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 150),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  // Button Text : This gives my button text
                  child: const Text("START"),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

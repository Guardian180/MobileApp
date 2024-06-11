import 'package:flutter/material.dart';
import 'package:math_jungle/nav_page.dart';

void main() {
  runApp(const MaterialApp(home: MainPage()));
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
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
        // This contains my text at the Top start is top,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Start Text : The text includes some styling that changes the fontSize, font and colour.
              const Text(
                "Welcome To the Math Jungle",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: "Itim",
                  color: Colors.white,
                ),
              ),
              // START Button : These lines initalises my buttons functionality,
              // this means that when the button is used it takes you to the nav page
              Expanded(
                child: Center(
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
              ),
              //Tiger Image : This contains my TIGER Within a column, end is bottom
              Center(child: Image.asset("assets/Tiger.png")),
            ],
          ),
        ),
      ),
    );
  }
}

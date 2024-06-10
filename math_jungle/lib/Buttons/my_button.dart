import 'package:flutter/material.dart';
import '../useables.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  final String child;
  final VoidCallback onTap;
  var buttonColour = Colors.greenAccent[400];

  MyButton({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (child == 'C') {
      buttonColour = Colors.green;
    } else if (child == 'DEL') {
      buttonColour = Colors.red;
    } else if (child == '=') {
      buttonColour = Colors.deepPurple;
    }
    return Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
              color: buttonColour,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(child, style: basicTextStyle),
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../useables.dart';

class ResultMessage extends StatelessWidget {
  final String message;
  final VoidCallback onTap;
  // ignore: prefer_typing_uninitialized_variables
  final icon;
  const ResultMessage(
      {required this.message,
      required this.onTap,
      required this.icon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
            Text(
              message,
              style: basicTextStyle,
            ),
            // Next Question
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.deepPurple[300],
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

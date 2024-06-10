import 'package:flutter/material.dart';

// name a widget that returns a `Scaffol` as a <SomeThink>>Page

class LevelZeroPage extends StatefulWidget {
  const LevelZeroPage({super.key});

  @override
  State<LevelZeroPage> createState() => _LevelZeroPageState();
}

class _LevelZeroPageState extends State<LevelZeroPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(); //<SCaffold so we name `this` widget `Page`
  }
}

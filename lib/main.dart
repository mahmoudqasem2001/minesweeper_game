
import 'package:flutter/material.dart';
import 'package:minisweeper_game/intoduction_screen.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroductionScrren(),
    );
  }
}
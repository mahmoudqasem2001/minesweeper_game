// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyBomb extends StatelessWidget {
  bool revealed;
  final function;
   MyBomb({super.key,  required this.revealed, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          color: revealed ?  Colors.green[800] : Colors.blueGrey,
          child: revealed ? Image.asset('assets/images/logo.png'): null,
        ),
      ),
    );
  }
}

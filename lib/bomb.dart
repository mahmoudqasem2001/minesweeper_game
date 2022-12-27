import 'package:flutter/material.dart';

class MyBomb extends StatelessWidget {
  bool revealed;
  final function;
   MyBomb({ required this.revealed, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          child: revealed ? Icon(Icons.fireplace): null,
          color: revealed ?  Colors.green[800] : Colors.blue.shade500,
        ),
      ),
    );
  }
}

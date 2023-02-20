// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';

class MyNumberBox extends StatelessWidget {
  final child;
  bool revealed;
  final function;
  MyNumberBox({super.key, this.child, required this.revealed, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          color: revealed ? Colors.green.shade200 : Colors.blueGrey,
          child: Center(
            child: Text(
              revealed ? ( child == 0 ?  '' :child.toString()) : '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: child == 1
                    ? Colors.blue
                    : (child == 2
                        ? Colors.green.shade600
                        : (child == 3 ? Colors.red : Colors.deepPurple)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

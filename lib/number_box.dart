import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyNumberBox extends StatelessWidget {
  final child;
  bool revealed;
  final function;
  MyNumberBox({this.child, required this.revealed, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          color: revealed ? Colors.green.shade200 : Colors.blue.shade500,
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

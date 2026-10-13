import 'package:flutter/material.dart';

class ExpandedWidget extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Colors.red,
          width: 100,
        ),
        Expanded(
          child: 
          Container(
            color: Colors.green,
            height: 100,
          ),
        ),

        Expanded(
          flex: 1,
          child: 
          Container(
            color: Colors.blue,
            height: 100,
          ),
        ),
        Expanded(
          flex: 1,
          child: 
          Container(
            color: const Color.fromARGB(255, 253, 231, 37),
            height: 100,
          ),
        ),
      ],
    );
  }
}
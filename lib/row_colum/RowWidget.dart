import 'package:flutter/material.dart';

class RowWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("isi row 1"),
        Text("isi row 2"),
        Text("isi row 3"),
      ]
    );
  }
}
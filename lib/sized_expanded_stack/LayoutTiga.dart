import 'package:flutter/material.dart';

class LatihanTiga extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.blue[200],
              height: 80,
              alignment: Alignment.center,
              child: Text ("Pemasukan")
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              color: Colors.green[200],
              height: 80,
              alignment: Alignment.center,
              child: Text ("pengeluaran")
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              color: Colors.yellow[200],
              height: 80,
              alignment: Alignment.center,
              child: Text ("saldo")
            ),
          )
        ],
      ),
    );
  }
}
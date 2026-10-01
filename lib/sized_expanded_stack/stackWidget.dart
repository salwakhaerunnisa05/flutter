import 'package:flutter/material.dart';

class stackWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(width: 200, height:200, color: Colors.red,),
        Positioned(
          bottom: 10,
          right: 10,
          child: Icon(Icons.favorite, color:Colors.white)
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Text("Label")
          ),
          Positioned(
            top: 25,
            right: 25,
            left: 25,
            child:Container(color: Colors.blue, height: 100, width: 100,)
          ),
      ],
    );
  }
}
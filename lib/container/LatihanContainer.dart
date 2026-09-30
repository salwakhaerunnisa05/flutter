import 'package:flutter/material.dart';

class LatihanContainer extends StatelessWidget {
  const LatihanContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:200,
      width: 300,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color.fromRGBO(132, 165, 157, 1.0),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color.fromRGBO(88, 129, 87, 1.0),
          width: 5,
        ),
        image: DecorationImage(
          image: NetworkImage(
            ""
          ),
          fit: BoxFit.cover,
        )
      ),
      child: Container(
        width: 200,
        height: 60,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 209, 102, 1.0),
          borderRadius: BorderRadius.circular(10),

        ),
      )

    );
  }
}
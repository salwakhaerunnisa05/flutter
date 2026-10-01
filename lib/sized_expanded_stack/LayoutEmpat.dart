import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 140,
              color: Colors.yellow[200],
            ),
            Positioned(
              bottom: -30,
              left: 20,
              child: SizedBox(
                width: 80,
                height: 80,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5Ldmw84d39HNdhrxgX1XByI78IAXFxm7BFiEqhRx9u9FXONDPEjI0LJ0&s=10"),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Salwa Khaerunnisa"),
                    Text("XII RPL 1"),
                  ], 
                ),
              ),
            ],
          ),
        ), 
        ElevatedButton(
          onPressed: () {}, child: Text("Follow")),
      ],
    ); 
  }
}
import 'package:flutter/material.dart';

class LayoutSatu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
      height: 72,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(132, 165, 157, 1.0),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 6,
          ),
        ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: CircleAvatar(backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5Ldmw84d39HNdhrxgX1XByI78IAXFxm7BFiEqhRx9u9FXONDPEjI0LJ0&s=10")),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Salwa Khaerunnisa"),
                    SizedBox(height: 4),
                    Text("Kelas XII RPL 1"),
                  ],
                ),
              ),
        ],
      ),
      )
    );
  }
}
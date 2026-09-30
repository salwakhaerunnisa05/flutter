import 'package:flutter/material.dart';

class ContainerSatu extends StatelessWidget {
  const ContainerSatu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-AuJ2tExzCd_911ascDEWAmKlPPzA_YheafK10TLUQjLwpgtKOXGNVeey&s=10"
          ),
          fit: BoxFit.cover,
        )
      ),
        child: Text("")
    );
  }
}
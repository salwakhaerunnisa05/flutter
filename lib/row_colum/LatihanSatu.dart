import 'package:flutter/material.dart';

class LatihanSatu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width:400,
        height:500,
        decoration: BoxDecoration(
          color: Color.fromRGBO(132, 165, 157, 1.0),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 5,
            color: Color.fromRGBO(88, 129, 87, 1.0),
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 400, 
              height: 300,
              decoration: BoxDecoration(
                
                image: DecorationImage(
                  image: NetworkImage
                  ("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDaYVweRp8SmOA2pMklPYoxQS2NdNCkZc3KOiTW-sShhksaorVoeXmG7g&s=10")
                  ) 
              ) ,

            ),
            Column(
              children: [
                Text("Nama : Upin & Ipin"),
                Text("NISN : 1234567"),
                Text("Kelas : 0 Besar"),

            ],)
          ],)
      )
    );
  }
}
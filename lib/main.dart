import 'package:flutter/material.dart';
import 'row_colum/LatihanDua.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Latihan satu"),
          backgroundColor: const Color.fromRGBO(246, 189, 96, 1.0),
          centerTitle: true,
        ), 
         body: LatihanDua(),
      ), //Scaffold
    ); //MaterialApp
  }
}

class HelloWidget extends StatelessWidget {
  const HelloWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
     child: Text("Hello, Flutter!", style: TextStyle(
       fontSize: 24,
       fontWeight: FontWeight.bold,
       color: const Color.fromARGB(255, 2, 244, 196),
       backgroundColor: Colors.black ,
     )),
    );
  }
}
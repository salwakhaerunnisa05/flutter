import 'package:flutter/material.dart';
// import 'package:flutter_salwa_rpl1/gridView/GambarDalamGridView.dart';  
import 'package:flutter_salwa_rpl1/latihangridlist/ListScreen.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text("Flutter App"),
        //   backgroundColor: const Color.fromRGBO(246, 189, 96, 1.0),
        //   centerTitle: true,
        // ), 
         body: ArticleListScreen()
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
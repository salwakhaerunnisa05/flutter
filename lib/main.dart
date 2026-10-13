import 'package:flutter/material.dart';
import 'package:flutter_salwa_rpl1/routes/app_routes.dart';
import 'package:flutter_salwa_rpl1/navigator.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: AppRoutes.routes,
    ); //MaterialApp
  }
}
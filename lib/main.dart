import 'package:flutter/material.dart';
import 'package:flutter_salwa_rpl1/routes/app_routes.dart';
import 'package:flutter_salwa_rpl1/navigator.dart';
import 'pages_auth/home_page.dart';
import 'pages_auth/login_page.dart';
import 'services/auth_service.dart';


// void main() {
//   runApp( MyApp());
// }

// class MyApp extends StatelessWidget {
//    MyApp({Key? key});
  
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       routes: AppRoutes.routes,
//     ); //MaterialApp
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final token = await AuthService().getToken();
  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const HomePage() : const LoginPage(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   final bool isLoggedIn;;const MyApp({super.key, required this.isLoggedIn});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title:"Flutter Pertamaku",
//       debugShowCheckedModeBanner: false,
//       initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.login,

//     )
//   }
// }
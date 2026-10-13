import 'package:flutter/material.dart';
import 'package:flutter_salwa_rpl1/latihangridlist/ListScreen.dart';  

class NavigatorWidget extends StatelessWidget {

  const NavigatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder : (context) {
                  return ArticleListScreen();
                }
              ),
            );
          },
          child: Text('List View'),
        ),
      ],
    );
  }
}
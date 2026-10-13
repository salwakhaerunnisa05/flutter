import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/about');
              },
              child: Text('Masuk Profile'),
            ),
            const SizedBox(height: 5,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/list-Screen');
              },
              child: Text('Masuk List'),
            ),
            const SizedBox(height: 5,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ListView');
              },
              child: Text('Masuk List View'),
            ),
            const SizedBox(height: 5,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ListViewBuilder');
              },
              child: Text('Masuk List View Builder'),
            ),
            const SizedBox(height: 5,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ListViewHorizontal');
              },
              child: Text('Masuk List View Horizontal'),
            ),
            const SizedBox(height: 5,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ListViewTerpisah');
              },
              child: Text('Masuk List View Terpisah'),
            ),
            const SizedBox(height: 5,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ListViewWidgetKustom');
              },
              child: Text('Masuk List View Custom'),
            ),

            const SizedBox(height: 15,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ColumnWidget');
              },
              child: Text('Masuk Coloumn Widget'),
            ),
            const SizedBox(height: 5,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/LatihanDua');
              },
              child: Text('Masuk Latihan Dua'),
            ),
            const SizedBox(height: 5,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/LatihanSatu');
              },
              child: Text('Masuk Latihan Satu'),
            ),
            const SizedBox(height: 5,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/RowColumnWidget');
              },
              child: Text('Masuk Row Column Widget'),
            ),
            const SizedBox(height: 5,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/RowWidget');
              },
              child: Text('Masuk Row Widget'),
            ),
            const SizedBox(height: 5,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ExpandedWidget');
              },
              child: Text('Masuk Expanded Widget'),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Map<String, String> data;
  const ArticleDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data['title'] ?? '',
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 20),
          Image.network(data['image'] ?? '', height: 200),
          const SizedBox(height: 20),
          Text(
            data['description'] ?? '',
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 20),
          Container(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Menggunakan titik koma (;) bukan koma (,)
              },
              child: const Text('kembali'),
            ),
          ),
        ],
      ),
    );
  }
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/Comment.dart';
import 'comment_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Fungsi untuk mengambil data dari API
  Future<List<Comment>> fetchComments() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/comments'),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Comment.fromJson(data)).toList();
    } else {
      throw Exception('Gagal memuat data komentar');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Komentar'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Comment>>(
        future: fetchComments(),
        builder: (context, snapshot) {
          // Saat data sedang dimuat
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Jika terjadi error
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // Jika data berhasil dimuat
          else if (snapshot.hasData) {
            final comments = snapshot.data!;
            return ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        '${comment.id}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      comment.name ?? 'Tanpa Nama',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      comment.email ?? 'Tanpa Email',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Navigasi ke Halaman Detail sambil mengirim objek comment
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(comment: comment),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Tidak ada data'));
        },
      ),
    );
  }
}
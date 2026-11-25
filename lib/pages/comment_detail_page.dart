import 'package:flutter/material.dart';
import '../models/Comment.dart';

class DetailPage extends StatelessWidget {
  final Comment comment;

  // Menerima data comment melalui constructor
  const DetailPage({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Komentar #${comment.id}'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge ID & Post ID
                Row(
                  children: [
                    Chip(
                      label: Text('Comment ID: ${comment.id}'),
                      backgroundColor: Colors.blue.shade100,
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text('Post ID: ${comment.postId}'),
                      backgroundColor: Colors.green.shade100,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Nama / Judul Komentar
                const Text(
                  'Judul / Nama:',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  comment.name ?? '-',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                // Email Pengirim
                const Text(
                  'Email Pengirim:',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Row(
                  children: [
                    const Icon(Icons.email, size: 16, color: Colors.blueAccent),
                    const SizedBox(width: 6),
                    Text(
                      comment.email ?? '-',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 32, thickness: 1),

                // Isi Komentar (Body)
                const Text(
                  'Isi Komentar:',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  comment.body ?? '-',
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
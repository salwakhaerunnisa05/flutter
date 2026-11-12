  import 'dart:async';
  import 'dart:convert';

  import 'package:http/http.dart' as http;

  import '../constants/api_constants.dart';
  import '../models/Post.dart';
  import '../models/Comment.dart';

  class ApiService{
    Future<List<Post>> fetchPosts() async {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.postsEndpoint}'
      );
      try {
        // 1) minta data (maksimal tunggu 10 detik)
        final response = await http.get(url).timeout(const Duration(seconds: 10));
        // 2) cek apakah berhasil
        if (response.statusCode == 200) {
          // 3. uabah teks json mnjd list 
          final List data =  jsonDecode(response.body);
          //4. bungkus item menjadi objek
          return data.map((e) => Post.fromJson(e)).toList();
        } else {
          throw Exception('Gagal memuat data (kode: ${response.statusCode})');
        }
      }on TimeoutException {
        throw Exception(' koneksi terlalu lama. coba lagi ');
      }
    }
  }

  class CommentService{
    Future<List<Comment>> fetchComments(int postId) async {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}/posts/$postId/comments'
      );
      try {
        // 1) minta data (maksimal tunggu 10 detik)
        final response = await http.get(url).timeout(const Duration(seconds: 10));
        // 2) cek apakah berhasil
        if (response.statusCode == 200) {
          // 3. uabah teks json mnjd list 
          final List data =  jsonDecode(response.body);
          //4. bungkus item menjadi objek
          return data.map((e) => Comment.fromJson(e)).toList();
        } else {
          throw Exception('Gagal memuat data (kode: ${response.statusCode})');
        }
      }on TimeoutException {
        throw Exception(' koneksi terlalu lama. coba lagi ');
      }
    }
  }
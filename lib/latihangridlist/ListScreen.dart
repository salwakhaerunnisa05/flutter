import 'package:flutter/material.dart';
import 'package:flutter_salwa_rpl1/latihangridlist/detailscreen.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({super.key});

  final List<Map<String, String>> articles = const [
    {
      'title': 'IP 18',
      'description': 'Burgundy',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2XgWnaackWfpLHV7Nkbs5ryWCVFVFflxWSw33-a8UVKIU7dn65IKstWtH&s=10',
    },
    {
      'title': 'IP 17',
      'description': 'Dark Blue',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT84MNPKWXHyKVYzgLgLqMMoxFwKBI6LwT21J3zSTAZmg&s=10',
    },
    {
      'title': 'IP 16',
      'description': 'Lavender',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHVArIo4lkXl1149eYMH5Uk1OgExSN4PZOh5Spk_OUzA&s',
    },
    {
      'title': 'IP 15',
      'description': 'Green',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdYJH6d5pYKK7b2TcfVJmp-ENdVmWlzCNaKvJeZLpRctOD7eLfIhBWnKcg&s=10',
    },
    {
      'title': 'IP 14',
      'description': 'Lilac',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7z6fuTbpjuvOtU-aAmO59PCx_k84diAVn-07JagfILtctF6AZOWgU2fNO&s=10',
    },
    {
      'title': 'IP 13',
      'description': 'Blue',
      'image': 'https://ibgadgetstore.id/wp-content/uploads/2024/09/image-13-1024x1024.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ArticleDetailScreen(data: article),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              children: [
                // image
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(article['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // text
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          article['title']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          article['description']!,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
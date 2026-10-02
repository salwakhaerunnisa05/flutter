import 'package:flutter/material.dart';

class TugasSatuListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // AppBar ala Instagram
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Instagram",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Billabong', // Bisa pakai font default jika belum set font IG
            fontSize: 26,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.chat_bubble_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      // Menggunakan SingleChildScrollView agar seluruh halaman bisa di-scroll ke bawah
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. HIGHLIGHT STORY (SCROLL HORIZONTAL) ---
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8, // Jumlah story/highlight
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        // Lingkaran Foto Profil / Highlight
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Colors.purple, Colors.orange, Colors.pink],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 27,
                              backgroundImage: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5Ldmw84d39HNdhrxgX1XByI78IAXFxm7BFiEqhRx9u9FXONDPEjI0LJ0&s=10",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "User ${index + 1}",
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Divider(height: 1, color: Colors.grey[300]),

            // --- 2. GRID / POSTS FEED (SCROLL VERTICAL) ---
            // Menggunakan GridView untuk menampilkan galeri foto ala profil/explore IG
            GridView.builder(
              itemCount: 12, // Jumlah foto grid
              shrinkWrap: true, // Wajib agar GridView bisa di dalam SingleChildScrollView
              physics: NeverScrollableScrollPhysics(), // Scroll diatur oleh SingleChildScrollView utama
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 kolom ke samping
                crossAxisSpacing: 2, // Jarak antar kolom
                mainAxisSpacing: 2,  // Jarak antar baris
              ),
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.grey[300],
                  child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5Ldmw84d39HNdhrxgX1XByI78IAXFxm7BFiEqhRx9u9FXONDPEjI0LJ0&s=10",
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
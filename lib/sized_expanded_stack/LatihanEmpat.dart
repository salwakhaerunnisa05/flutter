import 'package:flutter/material.dart';

class LatihanEmpat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- CARD PERTAMA (Salwa Khaerunnisa) ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 85,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(132, 165, 157, 1.0),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), 
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 20),  
                    SizedBox(
                      width: 70,
                      height: 60,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPwZ_LEWcI-se8UKf-c7qdBVUXWoGo8H4RgotJoLXlTQ&s=10"),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Salwa Khaerunnisa",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                               color: Color.fromRGBO(40, 48, 68, 1.0),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "XII RPL 1",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                               color: Color.fromRGBO(40, 48, 68, 1.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.notifications, size: 30),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),

        Expanded(
          child: Column( 
            children: [
              Container(
                height: 125,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(242, 132, 130, 1.0),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Belajar Flutter",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                               color: Color.fromRGBO(247, 237, 226, 1.0),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Belajar Dari Fundamental",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(247, 237, 226, 1.0),
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: 150,
                            height: 25,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(246, 189, 96, 1.0),
                                foregroundColor: Colors.black,
                              ),
                              child: Text(
                                "Mulai Belajar>",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(40, 48, 68, 1.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.flare_outlined, size: 75,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    SizedBox(width: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
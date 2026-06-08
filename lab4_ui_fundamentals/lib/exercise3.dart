import 'package:flutter/material.dart';

class LayoutBasicsDemo extends StatelessWidget {
  LayoutBasicsDemo({super.key});

  // Danh sách phim giả lập
  final List<String> movies = [
    'Avatar: The Way of Water',
    'Avengers: Endgame',
    'Inception',
    'Interstellar',
    'The Dark Knight',
    'Spider-Man: No Way Home'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 3: Layout Basics')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section 1: Thẻ Tiêu đề dạng Row (Ngang)
          Padding(
            padding: const EdgeInsets.all(16.0), // Spacing 16px
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Trending Movies',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                TextButton(onPressed: () {}, child: const Text('See All')),
              ],
            ),
          ),

          // Section 2: Danh sách cuộn dạng ListView trong Column (đã bọc Expanded)
          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Spacing 8px
                  child: Card(
                    color: Colors.blue[50],
                    child: ListTile(
                      leading: const Icon(Icons.movie, color: Colors.blue),
                      title: Text(
                        movies[index],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(Icons.play_arrow),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
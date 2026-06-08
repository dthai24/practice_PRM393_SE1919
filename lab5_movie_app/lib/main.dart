import 'package:flutter/material.dart';
import 'movie_model.dart';
import 'movie_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Detail App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Cấu hình màu nền trắng xám nhẹ giống hệt trong ảnh mẫu của bạn
        scaffoldBackgroundColor: const Color(0xFFF8F8FF), 
        useMaterial3: true,
      ),
      home: const MovieHomeScreen(),
    );
  }
}

class MovieHomeScreen extends StatelessWidget {
  const MovieHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề lớn góc trái màn hình: Movies (Đã fix hoàn toàn lỗi compile)
              const Text(
                'Movies',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121), // Mã màu đen xám chuẩn UI hiện đại
                ),
              ),
              const SizedBox(height: 20),
              
              // Danh sách cuộn hiển thị các Card phim mẫu
              Expanded(
                child: ListView.builder(
                  itemCount: sampleMovies.length,
                  itemBuilder: (context, index) {
                    final movie = sampleMovies[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Card(
                        elevation: 0,
                        // Bo tròn 20px và màu nền xám nhẹ khớp hoàn toàn 100% với ảnh mẫu 1
                        color: const Color(0xFFF1F0F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          
                          // 1. Ảnh Poster phim bo góc tròn nhẹ
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              movie.posterUrl,
                              width: 80,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          
                          // 2. Tên phim (Dune / Deadpool)
                          title: Text(
                            movie.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF212121),
                            ),
                          ),
                          
                          // 3. Điểm số đánh giá  + Chuỗi danh sách Thể loại phim
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              '★ ${movie.rating} • ${movie.genres.join(', ')}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          
                          // 4. Icon mũi tên nhọn điều hướng màu đen ở góc phải card
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.black87,
                          ),
                          
                          // Sự kiện chạm ngón tay: Điều hướng mượt mà sang trang Detail
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailScreen(movie: movie),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
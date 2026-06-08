import 'package:flutter/material.dart';
import 'movie_model.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      // Cấu hình AppBar có màu nền trắng và nút quay lại (Back Button) mặc định
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          movie.title,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Banner Poster lớn lồng chữ Tiêu đề phim (Dùng Stack + Gradient đổ bóng mờ chân thực)
            Stack(
              children: [
                Image.network(
                  movie.posterUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Thể loại phim (Genres) hiển thị dạng Chip bo viền mỏng giống hệt trong ảnh mẫu
                  Wrap(
                    spacing: 8.0,
                    children: movie.genres.map((genre) {
                      return Chip(
                        label: Text(genre, style: const TextStyle(color: Colors.grey)),
                        backgroundColor: const Color(0xFFF8F8FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Color(0xFFE0E0E0)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // 3. Phần văn bản tóm tắt mô tả nội dung phim (Overview)
                  Text(
                    movie.overview,
                    style: const TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),

                  // 4. Hàng nút tương tác chức năng đối xứng: Favorite, Rate, Share
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildActionButton(
                        icon: movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                        label: 'Favorite',
                        color: movie.isFavorite ? Colors.red : Colors.black54,
                        onTap: () {
                          setState(() {
                            movie.isFavorite = !movie.isFavorite; // Đổi trạng thái nút Trái tim
                          });
                        },
                      ),
                      _buildActionButton(icon: Icons.star_border, label: 'Rate', color: Colors.black54, onTap: () {}),
                      _buildActionButton(icon: Icons.share, label: 'Share', color: Colors.black54, onTap: () {}),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 5. Khối danh sách Trailers dưới dạng các ListTile đi kèm vạch phân cách Divider
                  const Text(
                    'Trailers',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(), // Tích hợp cuộn chung với trục màn hình chính
                    itemCount: movie.trailers.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            // Icon vòng tròn nút Play giống hệt ảnh của bạn
                            leading: const Icon(Icons.play_circle_filled, color: Colors.black87, size: 28),
                            title: Text(
                              movie.trailers[index],
                              style: const TextStyle(fontSize: 16, color: Colors.black87),
                            ),
                          ),
                          const Divider(height: 1, color: Color(0xFFEEEEEE)),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm Helper dựng cấu trúc khối nút Action kèm nhãn văn bản bên dưới
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        ],
      ),
    );
  }
}
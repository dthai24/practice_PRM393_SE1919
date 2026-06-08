import 'package:flutter/material.dart';

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1: Core Widgets'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView( // Cuộn trang nếu màn hình nhỏ
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Headline Text
            const Text(
              'Welcome to Flutter UI',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 20), // Tạo khoảng cách

            // 2. Material Icon
            const Icon(
              Icons.star,
              size: 50,
              color: Colors.amber,
            ),
            const SizedBox(height: 20),

            // 3. Image.network
            ClipRRect( // Bo góc cho ảnh đẹp hơn
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'https://picsum.photos/300/200', // Link ảnh mẫu ngẫu nhiên
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                // Hiển thị loading khi đang tải ảnh
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            const SizedBox(height: 20),

            // 4. Card containing a ListTile
            Card(
              elevation: 4, // Đổ bóng cho Card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const ListTile(
                leading: Icon(Icons.person, color: Colors.blue),
                title: Text('Nguyen Van A'),
                subtitle: Text('Flutter Developer'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
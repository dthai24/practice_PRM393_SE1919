import 'package:flutter/material.dart';
import 'exercise1.dart';
import 'exercise2.dart';
import 'exercise3.dart';
import 'exercise4.dart';
import 'exercise5.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Lab 4 Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      // Màn hình đầu tiên xuất hiện sẽ là Menu chính
      home: const Lab4MainMenu(),
    );
  }
}

// Lớp Menu chính chứa danh sách 5 bài tập
class Lab4MainMenu extends StatelessWidget {
  const Lab4MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Lab 4 - Main Menu'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Chọn bài tập để xem kết quả UI:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            
            // Nút bấm Bài 1
            _buildMenuButton(
              context,
              title: 'Exercise 1: Core Widgets',
              subtitle: 'Text, Image, Icon, Card, ListTile',
              icon: Icons.widgets,
              color: Colors.blue,
              destination: const CoreWidgetsDemo(),
            ),
            
            // Nút bấm Bài 2
            _buildMenuButton(
              context,
              title: 'Exercise 2: Input Widgets',
              subtitle: 'Slider, Switch, Radio, DatePicker',
              icon: Icons.input,
              color: Colors.green,
              destination: const InputControlsDemo(),
            ),
            
            // Nút bấm Bài 3
            _buildMenuButton(
              context,
              title: 'Exercise 3: Layout Basics',
              subtitle: 'Column, Row, Padding, ListView',
              icon: Icons.layers,
              color: Colors.orange,
              destination: LayoutBasicsDemo(), // Không có const vì danh sách phim động
            ),
            
            // Nút bấm Bài 4
            _buildMenuButton(
              context,
              title: 'Exercise 4: Scaffold & Theme',
              subtitle: 'AppBar, FAB, Light/Dark Mode Toggle',
              icon: Icons.palette,
              color: Colors.purple,
              destination: const ScaffoldThemeDemo(),
            ),
            
            // Nút bấm Bài 5
            _buildMenuButton(
              context,
              title: 'Exercise 5: Debug & Fix UI',
              subtitle: 'Sửa 4 lỗi layout phổ biến',
              icon: Icons.bug_report,
              color: Colors.red,
              destination: const DebugFixDemo(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget destination,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 3,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // Lệnh chuyển màn hình trong Flutter
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destination),
            );
          },
        ),
      ),
    );
  }
}
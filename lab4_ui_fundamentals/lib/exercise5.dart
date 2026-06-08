import 'package:flutter/material.dart';

class DebugFixDemo extends StatefulWidget {
  const DebugFixDemo({super.key});

  @override
  State<DebugFixDemo> createState() => _DebugFixDemoState();
}

class _DebugFixDemoState extends State<DebugFixDemo> {
  int _counter = 0; // Biến đếm
  DateTime? _selectedDate;

  // HÀM SỬA LỖI 4: Gọi từ một context hợp lệ
  void _showPicker() async {
    final DateTime? picked = await showDatePicker(
      context: context, // Truyền trực tiếp context của State class (luôn hợp lệ)
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      // HÀM SỬA LỖI 3: Thêm setState() để giao diện Render lại
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // HÀM SỬA LỖI 2: Bọc SingleChildScrollView ngoài cùng để chống tràn màn hình (Overflow) khi có bàn phím/màn hình nhỏ
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 5: Debug & Fix')),
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('--- FIX 1: ListView inside Column ---', style: TextStyle(fontWeight: FontWeight.bold)),
            
            // SỬA LỖI 1: Để dùng ListView trong Column, phải bọc nó bằng Container/SizedBox có chiều cao cố định (hoặc Expanded nếu không có cuộn ngoài)
            // Ở đây do bên ngoài có SingleChildScrollView, ta dùng SizedBox để giới hạn chiều cao ListView.
            SizedBox(
              height: 150, 
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
              ),
            ),

            const Divider(),
            const Text('--- FIX 2: Overflow Form Test ---', style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('Try adding many TextFields; SingleChildScrollView will prevent yellow stripes overflow.'),
            const TextField(decoration: InputDecoration(labelText: 'Input 1')),
            const TextField(decoration: InputDecoration(labelText: 'Input 2')),
            
            const Divider(),
            const Text('--- FIX 3: State Update ---', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Text('Counter Value: $_counter', style: const TextStyle(fontSize: 16)),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // SỬA LỖI 3: Phải bọc trong setState() để UI cập nhật giá trị mới lên màn hình
                    setState(() {
                      _counter++;
                    });
                  },
                  child: const Text('Increment'),
                ),
              ],
            ),

            const Divider(),
            const Text('--- FIX 4: DatePicker Context ---', style: TextStyle(fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: _showPicker, // Gọi hàm trực tiếp từ Widget Tree hợp lệ
              child: const Text('Open Date Picker'),
            ),
            Text(_selectedDate == null ? 'No Date' : 'Date: $_selectedDate'),
          ],
        ),
      ),
    );
  }
}
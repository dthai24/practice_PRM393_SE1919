import 'package:flutter_test/flutter_test.dart';
import 'package:lab6_responsive_ui/main.dart'; // Đảm bảo tên package trùng với dự án của bạn

void main() {
  testWidgets('Counter initial state test (Dummy for Lab 6)', (WidgetTester tester) async {
    // Chỉ cần kiểm tra xem ứng dụng ResponsiveMovieApp có khởi chạy thành công hay không
    await tester.pumpWidget(const ResponsiveMovieApp());
    expect(find.byType(ResponsiveMovieApp), findsOneWidget);
  });
}
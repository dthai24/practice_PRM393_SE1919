import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveMovieApp());
}

// ==========================================
// STEP 2: DEFINE MOVIE MODEL & SAMPLE DATA
// ==========================================
class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  const Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

// Danh sách dữ liệu phim mẫu tĩnh (Static Sample Data)
const List<Movie> allMovies = [
  Movie(
    title: 'Dune: Part Two',
    year: 2024,
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    posterUrl: 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?q=80&w=400&auto=format&fit=crop',
    rating: 8.6,
  ),
  Movie(
    title: 'Deadpool & Wolverine',
    year: 2024,
    genres: ['Action', 'Comedy'],
    posterUrl: 'https://images.unsplash.com/photo-1478760329108-5c3ed9d495a0?q=80&w=400&auto=format&fit=crop',
    rating: 8.3,
  ),
  Movie(
    title: 'Interstellar',
    year: 2014,
    genres: ['Sci-Fi', 'Drama'],
    posterUrl: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=400&auto=format&fit=crop',
    rating: 8.7,
  ),
  Movie(
    title: 'The Dark Knight',
    year: 2008,
    genres: ['Action', 'Crime', 'Drama'],
    posterUrl: 'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?q=80&w=400&auto=format&fit=crop',
    rating: 9.0,
  ),
  Movie(
    title: 'Spider-Man: Into the Spider-Verse',
    year: 2018,
    genres: ['Action', 'Animation', 'Comedy'],
    posterUrl: 'https://images.unsplash.com/photo-1635805737707-575885ab0820?q=80&w=400&auto=format&fit=crop',
    rating: 8.4,
  ),
];

// Danh sách các thể loại phim cố định để hiển thị bộ lọc
const List<String> availableGenres = [
  'Action',
  'Adventure',
  'Animation',
  'Comedy',
  'Crime',
  'Drama',
  'Sci-Fi',
];

// ==========================================
// STEP 3: BUILD THE BASE APP STRUCTURE
// ==========================================
class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Movie Browser',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GenreScreen(),
    );
  }
}

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  // Trạng thái các bộ lọc (State Variables)
  String _searchQuery = '';
  final Set<String> _selectedGenres = {};
  String _selectedSort = 'A-Z'; // Các tùy chọn: A-Z, Z-A, Year, Rating

  @override
  Widget build(BuildContext context) {
    // ---------------------------------------------------------
    // STEP 7: FILTER AND SORT THE MOVIE LIST (LOGIC)
    // ---------------------------------------------------------
    List<Movie> visibleMovies = allMovies.where((movie) {
      // 1. Lọc theo từ khóa Tìm kiếm (Không phân biệt chữ hoa/thường)
      final matchesSearch = movie.title.toLowerCase().contains(_searchQuery.toLowerCase());

      // 2. Lọc theo Thể loại được chọn (Nếu có chọn, phim phải chứa ít nhất 1 thể loại trong Set)
      final matchesGenre = _selectedGenres.isEmpty ||
          movie.genres.any((genre) => _selectedGenres.contains(genre));

      return matchesSearch && matchesGenre;
    }).toList();

    // 3. Sắp xếp danh sách sau khi lọc
    if (_selectedSort == 'A-Z') {
      visibleMovies.sort((a, b) => a.title.compareTo(b.title));
    } else if (_selectedSort == 'Z-A') {
      visibleMovies.sort((a, b) => b.title.compareTo(a.title));
    } else if (_selectedSort == 'Year') {
      visibleMovies.sort((a, b) => b.year.compareTo(a.year)); // Năm mới nhất lên đầu
    } else if (_selectedSort == 'Rating') {
      visibleMovies.sort((a, b) => b.rating.compareTo(a.rating)); // Điểm cao nhất lên đầu
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LAB 6.1: RESPONSIVE HERO & HEADING SECTION
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Find a Movie',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
                  ),
                  // BONUS ENHANCEMENT: Nút xóa nhanh tất cả các bộ lọc hiện tại
                  if (_searchQuery.isNotEmpty || _selectedGenres.isNotEmpty)
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _searchQuery = '';
                          _selectedGenres.clear();
                          _selectedSort = 'A-Z';
                        });
                      },
                      icon: const Icon(Icons.refresh, size: 18),
                      label: const Text('Clear Filters'),
                    ),
                ],
              ),
              const SizedBox(height: 16),

              // LAB 6.2: STEP 4 - RESPONSIVE SEARCH BAR
              TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search movie by title...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // LAB 6.2: STEP 5 - GENRE CHIPS USING WRAP
              Row(
                children: [
                  const Text(
                    'Genres',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  // BONUS ENHANCEMENT: Huy hiệu (Badge) đếm số lượng thể loại đang chọn
                  if (_selectedGenres.isNotEmpty)
                    Badge(
                      label: Text('${_selectedGenres.length}'),
                      backgroundColor: Colors.deepPurple,
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0, // Tự động xuống dòng khi màn hình co hẹp (Responsive)
                children: availableGenres.map((genre) {
                  final isSelected = _selectedGenres.contains(genre);
                  return FilterChip(
                    label: Text(genre),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedGenres.add(genre);
                        } else {
                          _selectedGenres.remove(genre);
                        }
                      });
                    },
                    selectedColor: Colors.deepPurple.withOpacity(0.2),
                    checkmarkColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // LAB 6.2: STEP 6 - SORT DROPDOWN BAR
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Results (${visibleMovies.length})',
                    style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.sort, size: 20, color: Colors.grey),
                      const SizedBox(width: 4),
                      DropdownButton<String>(
                        value: _selectedSort,
                        underline: const SizedBox(), // Ẩn lề gạch chân mặc định
                        items: const [
                          DropdownMenuItem(value: 'A-Z', child: Text('Sort: A-Z')),
                          DropdownMenuItem(value: 'Z-A', child: Text('Sort: Z-A')),
                          DropdownMenuItem(value: 'Year', child: Text('Sort: Year')),
                          DropdownMenuItem(value: 'Rating', child: Text('Sort: Rating')),
                        ],
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedSort = newValue;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // LAB 6.3: STEP 8 - RESPONSIVE MOVIE LIST (LAYOUTBUILDER)
              Expanded(
                child: visibleMovies.isEmpty
                    ? const Center(
                        child: Text('No movies match your criteria.', style: TextStyle(color: Colors.grey)),
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          // KIỂM TRA BREAKPOINT: Nếu chiều rộng màn hình lớn hơn hoặc bằng 800px (Tablet/Web)
                          if (constraints.maxWidth >= 800) {
                            return GridView.builder(
                              itemCount: visibleMovies.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Hiển thị cấu trúc 2 Cột
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                mainAxisExtent: 150, // Khóa chiều cao cố định của card trong Grid
                              ),
                              itemBuilder: (context, index) {
                                return _buildMovieCard(visibleMovies[index], isTablet: true);
                              },
                            );
                          } else {
                            // Ngược lại, nếu là màn hình nhỏ dưới 800px (Mobile phone)
                            return ListView.builder(
                              itemCount: visibleMovies.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: _buildMovieCard(visibleMovies[index], isTablet: false),
                                );
                              },
                            );
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm xây dựng thẻ hiển thị thông tin phim (Adaptive Movie Card Widget)
  Widget _buildMovieCard(Movie movie, {required bool isTablet}) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          // Điều chỉnh linh hoạt kích thước poster dựa trên kích thước màn hình thiết bị (LayoutBuilder logic)
          Image.network(
            movie.posterUrl,
            width: isTablet ? 120 : 100,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Year: ${movie.year}',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  // BONUS ENHANCEMENT: Hiển thị thanh điểm số sao trực quan
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '${movie.rating}/10',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
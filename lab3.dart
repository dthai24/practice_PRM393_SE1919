import 'dart:async';
import 'dart:convert';

/// EXERCISE 1 – PRODUCT MODEL & REPOSITORY


class Product {
  final int id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});

  @override
  String toString() => 'Product(id:$id, name:$name, price:$price)';
}

class ProductRepository {
  final StreamController<Product> _controller =
      StreamController<Product>.broadcast();

  final List<Product> _data = [
    Product(id: 1, name: "Laptop", price: 1200),
    Product(id: 2, name: "Phone", price: 800),
  ];

  Future<List<Product>> getAll() async {
    await Future.delayed(Duration(seconds: 1));
    return _data;
  }

  Stream<Product> liveAdded() => _controller.stream;

  void add(Product p) {
    _data.add(p);
    _controller.add(p);
  }
}

/// EXERCISE 2 – USER REPOSITORY WITH JSON

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
    );
  }

  @override
  String toString() => 'User(name:$name, email:$email)';
}

class UserRepository {
  Future<List<User>> fetchUsers() async {
    await Future.delayed(Duration(seconds: 1));

    String response = '''
    [
      {"name":"An","email":"an@gmail.com"},
      {"name":"Binh","email":"binh@gmail.com"},
      {"name":"Chi","email":"chi@gmail.com"}
    ]
    ''';

    List data = jsonDecode(response);

    return data.map((e) => User.fromJson(e)).toList();
  }
}


/// EXERCISE 3 – MICROTASK VS EVENT LOOP

void exercise3() {
  print("\nEXERCISE 3 - Microtask vs Event Queue");

  scheduleMicrotask(() {
    print("Microtask 1");
  });

  Future(() {
    print("Event Task 1");
  });

  scheduleMicrotask(() {
    print("Microtask 2");
  });

  Future(() {
    print("Event Task 2");
  });

  print("Main Thread");
}

/// EXERCISE 4 – STREAM TRANSFORMATION


void exercise4() {
  print("\nEXERCISE 4 - Stream Transform");

  Stream<int> stream = Stream.fromIterable([1, 2, 3, 4, 5]);

  stream
      .map((x) => x * x) // square
      .where((x) => x % 2 == 0) // filter even
      .listen((value) {
    print("Output: $value");
  });
}


/// EXERCISE 5 – FACTORY & CACHE (SINGLETON)


class Settings {
  static final Settings _instance = Settings._internal();

  String language = "EN";

  Settings._internal(); // private constructor

  factory Settings() {
    return _instance;
  }
}


/// MAIN


Future<void> main() async {
  print("LAB 3 – ADVANCED DART\n");

 
  /// EXERCISE 1
 
  print("EXERCISE 1 - Product Repository");

  final repo = ProductRepository();

  var list = await repo.getAll();
  print("All products: $list");

  repo.liveAdded().listen((p) {
    print("New product: $p");
  });

  repo.add(Product(id: 3, name: "Tablet", price: 600));

  await Future.delayed(Duration(seconds: 1));

  /// EXERCISE 2

  print("\nEXERCISE 2 - JSON User Repository");

  final userRepo = UserRepository();
  var users = await userRepo.fetchUsers();

  users.forEach(print);

  /// EXERCISE 3
  exercise3();

  await Future.delayed(Duration(seconds: 1));

  /// EXERCISE 4
  exercise4();

  await Future.delayed(Duration(seconds: 1));

  /// EXERCISE 5
  print("\nEXERCISE 5 - Singleton Factory");

  var a = Settings();
  var b = Settings();

  print("Same instance: ${identical(a, b)}");
}
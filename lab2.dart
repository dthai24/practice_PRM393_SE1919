import 'dart:async';

void main() async {
  print(" EXERCISE 1 ");
  exercise1();

  print("\n EXERCISE 2 ");
  exercise2();

  print("\n EXERCISE 3 ");
  exercise3();

  print("\n EXERCISE 4 ");
  exercise4();

  print("\n EXERCISE 5 ");
  await exercise5();
}

void exercise1() {
  int age = 20;
  double height = 1.75;
  String name = "Nam";
  bool isStudent = true;

  print("Name: $name");
  print("Age: $age");
  print("Height: $height m");
  print("Is student: $isStudent");
  print("Next year age: ${age + 1}");
}

void exercise2() {
  List<int> numbers = [10, 20, 30, 40];

  print("Original List: $numbers");
  print("First number: ${numbers[0]}");

  numbers.add(50);
  print("After add: $numbers");

  numbers.remove(20);
  print("After remove: $numbers");

  int a = 10;
  int b = 5;

  print("a + b = ${a + b}");
  print("a - b = ${a - b}");
  print("a == b : ${a == b}");
  print("a > b && b < 10 : ${a > b && b < 10}");

  String result = a > b ? "a is larger" : "b is larger";
  print(result);

  Set<String> fruits = {"Apple", "Banana", "Orange"};
  print("Set values: $fruits");

  Map<String, dynamic> student = {
    "name": "Nam",
    "age": 20,
    "grade": "A"
  };

  print("Student map: $student");
  print("Student name: ${student["name"]}");
}

void exercise3() {
  int score = 85;

  if (score >= 90) {
    print("Excellent");
  } else if (score >= 70) {
    print("Good");
  } else {
    print("Need improvement");
  }

  String day = "Friday";

  switch (day) {
    case "Monday":
      print("Start of the week");
      break;

    case "Friday":
      print("Almost weekend");
      break;

    default:
      print("Normal day");
  }

  print("For loop:");
  for (int i = 1; i <= 5; i++) {
    print(i);
  }

  List<String> colors = ["Red", "Green", "Blue"];

  print("For-in loop:");
  for (String color in colors) {
    print(color);
  }

  print("forEach loop:");
  colors.forEach((color) {
    print(color);
  });

  int sumResult = addNumbers(5, 7);
  print("Sum: $sumResult");

  int multiplyResult = multiply(4, 3);
  print("Multiply: $multiplyResult");
}

int addNumbers(int x, int y) {
  return x + y;
}

int multiply(int x, int y) => x * y;

class Car {
  String brand;

  Car(this.brand);

  Car.named() : brand = "Unknown";

  void startEngine() {
    print("$brand engine started.");
  }
}

class ElectricCar extends Car {
  int batteryLevel;

  ElectricCar(String brand, this.batteryLevel) : super(brand);

  @override
  void startEngine() {
    print("$brand electric engine is running silently.");
  }
}

void exercise4() {
  Car car1 = Car("Toyota");
  car1.startEngine();

  Car car2 = Car.named();
  car2.startEngine();

  ElectricCar tesla = ElectricCar("Tesla", 95);

  tesla.startEngine();

  print("Battery level: ${tesla.batteryLevel}%");
}

Future<void> loadData() async {
  print("Loading data...");

  await Future.delayed(Duration(seconds: 2));

  print("Data loaded!");
}

Future<void> exercise5() async {
  await loadData();

  String? nullableName;

  print("Name: ${nullableName ?? "Guest"}");
  print("Length: ${nullableName?.length}");

  String? city;

  if (DateTime.now().millisecond > 500) {
    city = "Hanoi";
  }

  if (city != null) {
    print("City length: ${city.length}");
  }

  Stream<int> numberStream =
      Stream.periodic(Duration(seconds: 1), (x) => x + 1).take(5);

  await for (int value in numberStream) {
    print("Stream value: $value");
  }
}
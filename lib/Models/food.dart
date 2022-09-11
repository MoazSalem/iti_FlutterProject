class Restaurants {
  final String name;
  final List<Food> menu;
  const Restaurants(
      {required this.name, required this.menu});
}
class Food {
  final String name;
  final double price;
  int count;
  Food({required this.name,required this.price, required this.count});
}

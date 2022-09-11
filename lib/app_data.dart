import 'package:foodly/Models/restaurant.dart';

import 'Models/category.dart';
import 'Models/food.dart';

const Categories_data = [
  Category(
      id: '1',
      title: 'Burger',
      imageUrl:
          'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80'),
  Category(
      id: '2',
      title: 'Pizza',
      imageUrl:
          'https://images.unsplash.com/photo-1628840042765-356cda07504e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80'),
  Category(
      id: '3',
      title: 'Salad',
      imageUrl:
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
  Category(
      id: '4',
      title: 'Dessert',
      imageUrl:
          'https://images.unsplash.com/photo-1607478900766-efe13248b125?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
  Category(
      id: '5',
      title: 'Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1614707585284-9cb9fc018387?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=490&q=80'),
  Category(
      id: '6',
      title: 'Fast Food',
      imageUrl:
          'https://images.unsplash.com/photo-1541592106381-b31e9677c0e5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80 '),
];

List<Restaurants> restaurantsMenu = [
  Restaurants(name: "McDonald's", menu: [
    Food(name: 'Big Mac', price: 82, count: 0),
    Food(name: 'Big Tasty', price: 132.5, count: 0),
    Food(name: 'McChicken', price: 88, count: 0),
  ]),
  Restaurants(name: "Tota Ice Cream", menu: [
    Food(name: 'Ice Cream', price: 10, count: 0),
    Food(name: 'Juice', price: 20, count: 0),
  ]),
  Restaurants(name: 'Maxim Pizza', menu: [
    Food(name: 'Chicken Ranch Pizza', price: 68, count: 0),
    Food(name: 'Shrimp Ranch Pizza', price: 81, count: 0),
  ]),
  Restaurants(name: 'KFC', menu: [
    Food(name: 'Mighty Zinger', price: 75, count: 0),
    Food(name: 'Twister Sandwich', price: 40, count: 0),
    Food(name: 'Rizo BBQ', price: 36, count: 0),
  ]),
  Restaurants(name: 'Frescas', menu: [
    Food(name: 'Sandwich', price: 56, count: 0),
    Food(name: 'Crepe', price: 66, count: 0),
  ]),
  Restaurants(name: 'Buffalo Burger', menu: [
    Food(name: 'Old School', price: 75, count: 0),
    Food(name: 'The Muscular', price: 90, count: 0),
    Food(name: 'Triple', price: 140, count: 0),
  ]),
];

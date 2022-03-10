import 'dart:collection';

import "package:flutter/material.dart";
import 'package:uuid/uuid.dart';
import 'package:zomateen/constants/GlobalConstants.dart';
import 'package:zomateen/models/food_item_model.dart';
import 'package:zomateen/models/order_model.dart';

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [
    Order(
      id: const Uuid().v4(),
      userName: "Roshan Jose",
      foodItems: [
        FoodItem(
          id: const Uuid().v4(),
          name: "Masala Dosa",
          imgUrl:
              "https://vismaifood.com/storage/app/uploads/public/8b4/19e/427/thumb__700_0_0_0_auto.jpg",
          price: 40,
          rating: 5,
        ),
        FoodItem(
          id: const Uuid().v4(),
          name: "Idli Vada",
          imgUrl:
              "https://5.imimg.com/data5/NE/OY/VP/ANDROID-103608865/product-jpeg-500x500.jpeg",
          price: 30,
          rating: 4,
        ),
      ],
      orderNo: 1,
      paid: false,
      price: 120,
      status: OrderStatus.pending,
    ),
    Order(
      id: const Uuid().v4(),
      userName: "Roshan Jose",
      foodItems: [
        FoodItem(
          id: const Uuid().v4(),
          name: "Masala Dosa",
          imgUrl:
              "https://vismaifood.com/storage/app/uploads/public/8b4/19e/427/thumb__700_0_0_0_auto.jpg",
          price: 40,
          rating: 5,
        ),
        FoodItem(
          id: const Uuid().v4(),
          name: "Idli Vada",
          imgUrl:
              "https://5.imimg.com/data5/NE/OY/VP/ANDROID-103608865/product-jpeg-500x500.jpeg",
          price: 30,
          rating: 4,
        ),
      ],
      orderNo: 1,
      paid: false,
      price: 120,
      status: OrderStatus.pending,
    ),
    Order(
      id: const Uuid().v4(),
      userName: "Roshan Jose",
      foodItems: [
        FoodItem(
          id: const Uuid().v4(),
          name: "Masala Dosa",
          imgUrl:
              "https://vismaifood.com/storage/app/uploads/public/8b4/19e/427/thumb__700_0_0_0_auto.jpg",
          price: 40,
          rating: 5,
        ),
        FoodItem(
          id: const Uuid().v4(),
          name: "Idli Vada",
          imgUrl:
              "https://5.imimg.com/data5/NE/OY/VP/ANDROID-103608865/product-jpeg-500x500.jpeg",
          price: 30,
          rating: 4,
        ),
      ],
      orderNo: 1,
      paid: false,
      price: 120,
      status: OrderStatus.inprogress,
    ),
    Order(
      id: const Uuid().v4(),
      userName: "Roshan Jose",
      foodItems: [
        FoodItem(
          id: const Uuid().v4(),
          name: "Masala Dosa",
          imgUrl:
              "https://vismaifood.com/storage/app/uploads/public/8b4/19e/427/thumb__700_0_0_0_auto.jpg",
          price: 40,
          rating: 5,
        ),
        FoodItem(
          id: const Uuid().v4(),
          name: "Idli Vada",
          imgUrl:
              "https://5.imimg.com/data5/NE/OY/VP/ANDROID-103608865/product-jpeg-500x500.jpeg",
          price: 30,
          rating: 4,
        ),
      ],
      orderNo: 1,
      paid: false,
      price: 120,
      status: OrderStatus.inprogress,
    ),
    Order(
      id: const Uuid().v4(),
      userName: "Roshan Jose",
      foodItems: [
        FoodItem(
          id: const Uuid().v4(),
          name: "Masala Dosa",
          imgUrl:
              "https://vismaifood.com/storage/app/uploads/public/8b4/19e/427/thumb__700_0_0_0_auto.jpg",
          price: 40,
          rating: 5,
        ),
        FoodItem(
          id: const Uuid().v4(),
          name: "Idli Vada",
          imgUrl:
              "https://5.imimg.com/data5/NE/OY/VP/ANDROID-103608865/product-jpeg-500x500.jpeg",
          price: 30,
          rating: 4,
        ),
      ],
      orderNo: 1,
      paid: false,
      price: 120,
      status: OrderStatus.ready,
    ),
    Order(
      id: const Uuid().v4(),
      userName: "Roshan Jose",
      foodItems: [
        FoodItem(
          id: const Uuid().v4(),
          name: "Masala Dosa",
          imgUrl:
              "https://vismaifood.com/storage/app/uploads/public/8b4/19e/427/thumb__700_0_0_0_auto.jpg",
          price: 40,
          rating: 5,
        ),
        FoodItem(
          id: const Uuid().v4(),
          name: "Idli Vada",
          imgUrl:
              "https://5.imimg.com/data5/NE/OY/VP/ANDROID-103608865/product-jpeg-500x500.jpeg",
          price: 30,
          rating: 4,
        ),
      ],
      orderNo: 1,
      paid: false,
      price: 120,
      status: OrderStatus.ready,
    ),
  ];

  UnmodifiableListView<Order> get orders => UnmodifiableListView(_orders);

  void create_order(Order order) {
    _orders.add(order);
    notifyListeners();
  }

  void update_order_status(String id, OrderStatus status) {
    for (var element in _orders) {
      if (element.id == id) {
        element.status = status;
      }
    }

    notifyListeners();
  }

  void delete_order() {
    _orders.clear();
    notifyListeners();
  }
}

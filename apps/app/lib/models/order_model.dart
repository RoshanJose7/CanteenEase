import 'package:zomateen/constants/GlobalConstants.dart';
import 'package:zomateen/models/food_item_model.dart';

class Order {
  late String id;
  late int orderNo;
  late String userName;
  late double price;
  late bool paid;
  late OrderStatus status;
  late List<FoodItem> foodItems;

  Order({
    required this.id,
    required this.orderNo,
    required this.userName,
    required this.price,
    required this.foodItems,
    required this.paid,
    required this.status,
  });
}

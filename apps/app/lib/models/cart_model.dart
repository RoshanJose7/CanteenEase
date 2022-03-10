import 'package:zomateen/models/user_model.dart';

class Cart {
  String id;
  User user;
  List<String> foodItems;

  Cart({
    required this.id,
    required this.user,
    required this.foodItems,
  });
}

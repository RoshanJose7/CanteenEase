import 'package:zomateen/models/cart_model.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String? userAvatar;
  final bool isAdmin;
  final List<dynamic> favorites;
  final List<dynamic> orders;
  final Cart? cart;

  User({
    required this.userAvatar,
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.favorites,
    required this.orders,
    required this.cart,
    required this.isAdmin,
  });
}

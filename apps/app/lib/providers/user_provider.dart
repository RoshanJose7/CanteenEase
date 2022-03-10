import 'package:flutter/material.dart';
import 'package:zomateen/models/user_model.dart';

class UserProvider with ChangeNotifier {
  late User? _user = null;

  User? get user => _user;
  set setUser(User? _usr) {
    _user = _usr;
  }

  void toggle_fav(String id, bool fav) {
    if (fav) {
      _user!.favorites.add(id);
    } else {
      _user!.favorites.remove(id);
    }

    notifyListeners();
  }

  void toggle_cart_item(String id, bool addToCart) {
    if (addToCart) {
      _user!.cart!.foodItems.add(id);
    } else {
      _user!.cart!.foodItems.remove(id);
    }

    notifyListeners();
  }

  void remove_all_cart_items() {
    _user!.cart!.foodItems.clear();
    notifyListeners();
  }
}

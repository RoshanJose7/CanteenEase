import 'dart:collection';
import 'package:file_picker/file_picker.dart';
import "package:flutter/material.dart";
import 'package:zomateen/api/food_api.dart';
import 'package:zomateen/models/food_item_model.dart';

class FoodItemProvider with ChangeNotifier {
  final FoodAPI _foodApi = FoodAPI();
  List<FoodItem> _food_items = [];

  UnmodifiableListView<FoodItem> get food_items =>
      UnmodifiableListView(_food_items);

  FoodItemProvider() {
    get_food_items();
  }

  void get_food_items() async {
    List<dynamic> res = await _foodApi.getFoodItems();
    List<FoodItem> _temp = [];

    for (var fi in res) {
      _temp.add(
        FoodItem(
          id: fi['id'],
          name: fi['name'],
          imgUrl: fi['filepath'],
          price: fi['price'],
          rating: 5,
        ),
      );
    }

    _food_items = _temp;

    notifyListeners();
  }

  Future<bool> add_food_item(String name, int price, PlatformFile file) async {
    bool res = await _foodApi.addFoodItem(name, price, file);

    get_food_items();
    return res;
  }

  Future<bool> edit_food_item(
      String id, String name, int price, PlatformFile file) async {
    bool res = await _foodApi.editFoodItem(id, name, price, file);

    get_food_items();
    return res;
  }

  Future<bool> remove_food_item(int idx, String id) async {
    _food_items.removeAt(idx);
    bool res = await _foodApi.deleteFoodItem(id);

    notifyListeners();
    return res;
  }
}

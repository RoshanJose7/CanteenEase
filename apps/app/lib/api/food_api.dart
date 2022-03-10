import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:zomateen/constants/GlobalConstants.dart';
import 'package:zomateen/models/food_item_model.dart';

class FoodAPI {
  final Dio dio = Dio();

  Future getFoodItems() async {
    try {
      Response res = await dio.get(host + "food/");

      if (res.data['statusCode'] == 202) {
        List<dynamic> foodItems = json.decode(res.data['foodItems']);
        return foodItems;
      }

      return null;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
      }

      return null;
    }
  }

  Future<FoodItem?> getFoodItem(String id) async {
    try {
      Response res = await dio.get(host + "food/", queryParameters: {"id": id});
      if (res.data['statusCode'] == 202) return res.data['foodItem'];
      return null;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
      }

      return null;
    }
  }

  Future<bool> addFoodItem(String name, int price, PlatformFile file) async {
    try {
      var formData = FormData.fromMap({
        'name': name,
        'price': price,
        'foodpic':
            await MultipartFile.fromFile(file.path!, filename: file.name),
      });

      Response res = await dio.post(host + "food/", data: formData);
      if (res.data['statusCode'] == 202) return true;

      return false;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
      }
      return false;
    }
  }

  Future<bool> editFoodItem(
      String id, String name, int price, PlatformFile file) async {
    try {
      var formData = FormData.fromMap({
        'id': id,
        'name': name,
        'price': price,
        'foodpic':
            await MultipartFile.fromFile(file.path!, filename: file.name),
      });

      Response res = await dio.patch(host + "food/", data: formData);
      if (res.data['statusCode'] == 202) return true;

      return false;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
      }
      return false;
    }
  }

  Future<bool> deleteFoodItem(String id) async {
    try {
      Response res = await dio.delete(host + "food/", data: {'id': id});

      if (res.data['statusCode'] == 202) return true;
      return false;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
      }

      return false;
    }
  }
}

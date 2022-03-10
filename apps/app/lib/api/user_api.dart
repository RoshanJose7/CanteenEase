import 'package:dio/dio.dart';
import 'package:zomateen/models/user_model.dart';

class UserAPI {
  String host = "http://10.0.2.2:8000/";
  final Dio dio = Dio();

  Future<User?> login(String email, String password) async {
    try {
      Response res = await dio.post(host + "auth/login/", data: {
        'email': email,
        'password': password,
      });

      if (res.data['statusCode'] == 202) {
        User user = User(
          id: res.data['user']['id'],
          email: res.data['user']['email'],
          name: res.data['user']['name'],
          password: res.data['user']['password'],
          userAvatar: res.data['user']['userAvatar'],
          isAdmin: res.data['user']['isAdmin'],
          cart: res.data['user']['cart'],
          orders: res.data['user']['orders'],
          favorites: res.data['user']['favorites'],
        );

        return user;
      }

      return null;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
      }

      return null;
    }
  }

  Future<bool> signup(
      String name, String email, String password, bool isAdmin) async {
    try {
      Response res = await dio.post(host + "auth/signup/", data: {
        'name': name,
        'email': email,
        'password': password,
        'isAdmin': isAdmin,
      });

      if (res.data['statusCode'] == 202) {
        return true;
      }

      return false;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
      }

      return false;
    }
  }

  // void getUser(String? id) async {
  //   try {
  //     Response res = await dio.get(
  //       host + "auth/",
  //       queryParameters: {"id": "80753447-14a8-4a32-85b5-26f1a4a3ad57"},
  //     );

  //     User user = User(
  //       id: res.data['id'],
  //       email: res.data['email'],
  //       name: res.data['name'],
  //       password: res.data['password'],
  //       userAvatar: res.data['userAvatar'],
  //       isAdmin: res.data['isAdmin'],
  //       cart: res.data['cart'],
  //       orders: res.data['orders'],
  //       favorites: res.data['favorites'],
  //     );

  //   } on DioError catch (e) {
  //     if (e.response != null) {
  //       print(e.response?.data);
  //     }
  //   }
  // }
}

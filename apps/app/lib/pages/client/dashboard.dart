import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:zomateen/pages/custom_drawer.dart';
import 'package:zomateen/providers/food_item_provider.dart';

import 'cart_page.dart';
import 'favorites_page.dart';
import 'home_page.dart';
import 'notifications_page.dart';

class ClientDashboard extends StatefulWidget {
  const ClientDashboard({Key? key}) : super(key: key);

  @override
  _ClientDashboardState createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
  DateTime? _lastPressedAt;

  final List<Widget> _pages = const [
    ClientHomePage(),
    ClientFavoritesPage(),
    ClientNotificationsPage(),
    ClientCartPage()
  ];

  @override
  Widget build(BuildContext context) {
    // Provider.of<FoodItemProvider>(context).get_food_items();

    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null ||
            (DateTime.now().difference(_lastPressedAt!) >
                const Duration(seconds: 1))) {
          Fluttertoast.showToast(
            fontSize: 12.0,
            msg: "Press again to exit",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            textColor: Colors.black87,
            gravity: ToastGravity.CENTER,
          );

          _lastPressedAt = DateTime.now();
          return false;
        }

        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomDrawer(pages: _pages),
        ),
      ),
    );
  }
}

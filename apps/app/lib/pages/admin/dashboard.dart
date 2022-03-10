import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zomateen/pages/admin/add_food_page.dart';
import 'package:zomateen/pages/admin/manage_food_items_page.dart';
import 'package:zomateen/pages/admin/manage_orders_page.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIdx = 0;
  DateTime? _lastPressedAt;

  final List<Widget> _pages = const [
    ManageOrdersPage(),
    ManageFoodItemsPage(),
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
          child: _pages[_currentIdx],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIdx,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.food_bank), label: "Manage Orders"),
            BottomNavigationBarItem(
                icon: Icon(Icons.admin_panel_settings),
                label: "Manage Food Items"),
          ],
          onTap: (idx) => setState(() {
            _currentIdx = idx;
          }),
          showUnselectedLabels: false,
        ),
        floatingActionButton: _currentIdx == 1
            ? FloatingActionButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const AddFoodpage())),
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}

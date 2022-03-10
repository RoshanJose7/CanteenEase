import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomateen/constants/ColorScheme.dart';
import 'package:zomateen/pages/admin/dashboard.dart';
import 'package:zomateen/pages/client/dashboard.dart';
import 'package:zomateen/pages/signin_page.dart';
import 'package:zomateen/pages/signup_page.dart';
import 'package:zomateen/providers/food_item_provider.dart';
import 'package:zomateen/providers/order_provider.dart';
import 'package:zomateen/providers/user_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FoodItemProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context).user;

    return MaterialApp(
      title: 'Zomateen',
      debugShowCheckedModeBanner: false,
      theme: LightTheme,
      initialRoute: _user == null ? "/signin" : "/client/dashboard",
      routes: {
        "/signin": (context) => const SigninPage(),
        "/signup": (context) => const SignupPage(),
        "/client/dashboard": (context) => const ClientDashboard(),
        "/admin/dashboard": (context) => const AdminDashboard(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomateen/components/cart_food_item_component.dart';
import 'package:zomateen/providers/food_item_provider.dart';
import 'package:zomateen/providers/user_provider.dart';

class ClientCartPage extends StatefulWidget {
  const ClientCartPage({Key? key}) : super(key: key);

  @override
  _ClientCartPageState createState() => _ClientCartPageState();
}

class _ClientCartPageState extends State<ClientCartPage> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _items = Provider.of<FoodItemProvider>(context).food_items;
    final _cart = Provider.of<UserProvider>(context).user!.cart;
    List cartItems = [];
    double priceTotal = 0;

    if (_cart != null) {
      for (var fav in _cart.foodItems) {
        for (var item in _items) {
          if (item.id == fav) {
            priceTotal += item.price;
            cartItems.add(item);
          }
        }
      }
    }

    return Column(
      children: [
        Container(
          height: 100,
          width: double.infinity,
          color: _theme.primaryColor,
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Items ",
                    style: _theme.textTheme.headline5,
                  ),
                  Text(
                    _cart != null ? _cart.foodItems.length.toString() : "0",
                    style: _theme.textTheme.headline5,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: _theme.textTheme.headline6,
                  ),
                  Text(
                    "Rs $priceTotal",
                    style: _theme.textTheme.headline6
                        ?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: _cart == null
              ? const Center(
                  child: Text(
                    "Cart is Empty!",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  itemCount: cartItems.length,
                  itemBuilder: (context, idx) => CartFoodItemComponent(
                    id: cartItems[idx].id,
                    name: cartItems[idx].name,
                    imgUrl: cartItems[idx].imgUrl,
                    price: cartItems[idx].price,
                    rating: cartItems[idx].rating,
                  ),
                ),
        ),
      ],
    );
  }
}

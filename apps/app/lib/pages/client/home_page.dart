import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomateen/components/food_item_component.dart';
import 'package:zomateen/constants/GlobalConstants.dart';
import 'package:zomateen/providers/food_item_provider.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({Key? key}) : super(key: key);

  @override
  _ClientHomePageState createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  @override
  Widget build(BuildContext context) {
    final _food_items = Provider.of<FoodItemProvider>(context).food_items;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      itemCount: _food_items.length,
      itemBuilder: (context, idx) => FoodItemComponent(
        id: _food_items[idx].id,
        name: _food_items[idx].name,
        imgUrl: host + _food_items[idx].imgUrl,
        price: _food_items[idx].price,
        rating: _food_items[idx].rating,
      ),
    );
  }
}

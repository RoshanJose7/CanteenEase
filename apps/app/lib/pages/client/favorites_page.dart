import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomateen/components/favorite_food_item_component.dart';
import 'package:zomateen/providers/food_item_provider.dart';
import 'package:zomateen/providers/user_provider.dart';

class ClientFavoritesPage extends StatefulWidget {
  const ClientFavoritesPage({Key? key}) : super(key: key);

  @override
  _ClientFavoritesPageState createState() => _ClientFavoritesPageState();
}

class _ClientFavoritesPageState extends State<ClientFavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final _items = Provider.of<FoodItemProvider>(context).food_items;
    final _favorites = Provider.of<UserProvider>(context).user!.favorites;
    List favs = [];
    
    for(var fav in _favorites) {
      for (var item in _items) {
        if (item.id == fav) favs.add(item);
      }
    }

    return _favorites.isEmpty ? const Center(
      child: Text("No Favorites Yet!", style: TextStyle(color: Colors.black),),
    ) : ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      itemCount: favs.length,
      itemBuilder: (context, idx) =>
        FavoriteFoodItemComponent(
          id: favs[idx].id,
          name: favs[idx].name,
          imgUrl:favs[idx].imgUrl,
          price: favs[idx].price,
          rating: favs[idx].rating,
        ),
    );
  }
}

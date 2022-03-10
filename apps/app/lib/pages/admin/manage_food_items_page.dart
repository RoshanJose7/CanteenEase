import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomateen/api/food_api.dart';
import 'package:zomateen/constants/GlobalConstants.dart';
import 'package:zomateen/pages/admin/edit_food_page.dart';
import 'package:zomateen/providers/food_item_provider.dart';

class ManageFoodItemsPage extends StatefulWidget {
  const ManageFoodItemsPage({Key? key}) : super(key: key);

  @override
  _ManageFoodItemsPageState createState() => _ManageFoodItemsPageState();
}

class _ManageFoodItemsPageState extends State<ManageFoodItemsPage> {
  @override
  Widget build(BuildContext context) {
    final _foodItems = Provider.of<FoodItemProvider>(context).food_items;
    FoodAPI _foodApi = FoodAPI();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (_foodItems.isEmpty)
              const Center(
                child: Text("No Food Items"),
              )
            else
              for (int idx = 0; idx < _foodItems.length; idx++)
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        host + _foodItems[idx].imgUrl,
                        height: 50,
                        width: 100,
                      ),
                      Column(
                        children: [
                          Text(_foodItems[idx].name),
                          Text(_foodItems[idx].price.toString()),
                          Row(
                            children: [
                              for (int i = 0; i < _foodItems[idx].rating; i++)
                                Icon(
                                  Icons.star_rounded,
                                  color: Theme.of(context).primaryColor,
                                ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => EditFoodpage(
                                  id: _foodItems[idx].id,
                                  imgUrl: _foodItems[idx].imgUrl,
                                  name: _foodItems[idx].name,
                                  price: _foodItems[idx].price,
                                ),
                              ),
                            ),
                            icon: const Icon(Icons.edit_attributes,
                                color: Colors.green),
                          ),
                          IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    "Confirm Delete?",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  action: SnackBarAction(
                                    label: "Delete",
                                    textColor: Colors.redAccent,
                                    onPressed: () async {
                                      await _foodApi
                                          .deleteFoodItem(_foodItems[idx].id);
                                    },
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.delete,
                                color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

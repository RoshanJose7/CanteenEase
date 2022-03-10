import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomateen/components/order_card_component.dart';
import 'package:zomateen/constants/GlobalConstants.dart';
import 'package:zomateen/providers/order_provider.dart';

class ManageOrdersPage extends StatefulWidget {
  const ManageOrdersPage({Key? key}) : super(key: key);

  @override
  _ManageOrdersPageState createState() => _ManageOrdersPageState();
}

class _ManageOrdersPageState extends State<ManageOrdersPage> {
  @override
  Widget build(BuildContext context) {
    final _orders = Provider.of<OrderProvider>(context).orders;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pending",
                  style: TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Show All"),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < _orders.length; i++)
                    if (_orders[i].status == OrderStatus.pending)
                      OrderCard(order: _orders[i], color: Colors.redAccent)
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pending",
                  style: TextStyle(
                    color: Colors.orange,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Show All"),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < _orders.length; i++)
                    if (_orders[i].status == OrderStatus.inprogress)
                      OrderCard(order: _orders[i], color: Colors.orange)
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Ready",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Show All"),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < _orders.length; i++)
                    if (_orders[i].status == OrderStatus.ready)
                      OrderCard(order: _orders[i], color: Colors.green)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

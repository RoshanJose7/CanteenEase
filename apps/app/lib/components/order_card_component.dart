import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zomateen/constants/GlobalConstants.dart';
import 'package:zomateen/models/order_model.dart';
import 'package:zomateen/providers/order_provider.dart';

class OrderCard extends StatefulWidget {
  final Order order;
  final Color color;

  const OrderCard({
    Key? key,
    required this.order,
    required this.color,
  }) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  double totalPrice = 0;

  @override
  void initState() {
    for (int i = 0; i < widget.order.foodItems.length; i++) {
      totalPrice += widget.order.foodItems[i].price;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _ordersProvider = Provider.of<OrderProvider>(context);
    final _theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(right: 20),
      constraints: const BoxConstraints(
        maxWidth: 300,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 10,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("#${widget.order.orderNo}",
                        style: _theme.textTheme.headline6),
                    const SizedBox(width: 5),
                    SvgPicture.asset("assets/check.svg")
                  ],
                ),
                Text(widget.order.userName, style: _theme.textTheme.bodyText2),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFF000000).withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        ListView.builder(
                          itemCount: widget.order.foodItems.length,
                          shrinkWrap: true,
                          itemBuilder: (ctx, idx) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.order.foodItems[idx].name),
                                SizedBox(
                                  width: 90,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("x1"),
                                      Text(widget.order.foodItems[idx].price
                                          .toString()),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        Divider(
                          thickness: 2,
                          color: const Color(0xFF000000).withOpacity(0.2),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total"),
                            SizedBox(
                              width: 90,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("x2"),
                                  Text(totalPrice.toString()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (widget.order.status == OrderStatus.pending)
                          ElevatedButton(
                            onPressed: () {
                              _ordersProvider.update_order_status(
                                  widget.order.id, OrderStatus.inprogress);
                            },
                            child: const Text("Accept"),
                            style: ElevatedButton.styleFrom(
                              primary: widget.color,
                            ),
                          )
                        else if (widget.order.status == OrderStatus.inprogress)
                          ElevatedButton(
                            onPressed: () {
                              _ordersProvider.update_order_status(
                                  widget.order.id, OrderStatus.ready);
                            },
                            child: const Text("Ready"),
                            style: ElevatedButton.styleFrom(
                              primary: widget.color,
                            ),
                          ),
                        const SizedBox(width: 5),
                        if (widget.order.status == OrderStatus.pending)
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text("Cancel"),
                            style: OutlinedButton.styleFrom(
                              primary: widget.color,
                              side: BorderSide(
                                width: 1,
                                color: widget.color,
                              ),
                            ),
                          ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_downward_rounded,
                          size: 20,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

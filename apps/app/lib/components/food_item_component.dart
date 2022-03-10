import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomateen/providers/user_provider.dart';

class FoodItemComponent extends StatefulWidget {
  final String id;
  final String name;
  final String imgUrl;
  final int price;
  final int rating;

  const FoodItemComponent({
    Key? key,
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.price,
    required this.rating,
  }) : super(key: key);

  @override
  State<FoodItemComponent> createState() => _FoodItemComponentState();
}

class _FoodItemComponentState extends State<FoodItemComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 220,
        upperBound: 350);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context);
    final _theme = Theme.of(context);
    final _fav_items = Provider.of<UserProvider>(context).user!.favorites;

    bool? inCart = _user.user!.cart?.foodItems.contains(widget.id);
    bool isFav = _fav_items.contains(widget.id);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          toggle();

          setState(() {
            isOpen = !isOpen;
          });
        },
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (ctx, child) {
            return SizedBox(
              height: _animationController.value,
              child: Stack(
                children: [
                  Container(
                    height: _animationController.value - 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 14,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child:
                        Align(alignment: Alignment.bottomCenter, child: child),
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 14,
                          spreadRadius: 4,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(widget.imgUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: AnimatedOpacity(
                      opacity: isOpen ? 0 : 1,
                      duration: const Duration(milliseconds: 350),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0),
                                Colors.black.withOpacity(0.5),
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.name,
                                    style: _theme.textTheme.headline5?.copyWith(
                                        color: _theme.colorScheme.background),
                                  ),
                                  Row(
                                    children: [
                                      for (int i = 0; i < widget.rating; i++)
                                        const Icon(
                                          Icons.star_rate_sharp,
                                          color: Colors.amber,
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              inCart != null || inCart == true
                                  ? OutlinedButton(
                                      style: _theme.outlinedButtonTheme.style,
                                      onPressed: () => _user.toggle_cart_item(
                                          widget.id, false),
                                      child: const Text("Added to Cart"),
                                    )
                                  : ElevatedButton(
                                      style: _theme.elevatedButtonTheme.style,
                                      onPressed: () => _user.toggle_cart_item(
                                          widget.id, true),
                                      child: const Text("Add to Cart"),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: IconButton(
                      onPressed: () => _user.toggle_fav(widget.id, !isFav),
                      icon: isFav
                          ? Icon(
                              Icons.favorite,
                              color: _theme.primaryColor,
                            )
                          : Icon(
                              Icons.favorite_outline,
                              color: _theme.primaryColor,
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
          child: AnimatedOpacity(
            opacity: isOpen ? 1 : 0,
            duration: const Duration(milliseconds: 400),
            child: SizedBox(
              height: 350 - 240,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: _theme.textTheme.headline5
                                ?.copyWith(color: _theme.colorScheme.primary),
                          ),
                          Row(
                            children: [
                              for (int i = 0; i < widget.rating; i++)
                                const Icon(
                                  Icons.star_rate_sharp,
                                  color: Colors.amber,
                                ),
                            ],
                          ),
                        ],
                      ),
                      inCart != null || inCart == true
                          ? OutlinedButton(
                              style: _theme.outlinedButtonTheme.style,
                              onPressed: () =>
                                  _user.toggle_cart_item(widget.id, false),
                              child: const Text("Added to Cart"),
                            )
                          : ElevatedButton(
                              style: _theme.elevatedButtonTheme.style,
                              onPressed: () =>
                                  _user.toggle_cart_item(widget.id, true),
                              child: const Text("Add to Cart"),
                            ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "₹ ${widget.price}",
                    style: _theme.textTheme.headline5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

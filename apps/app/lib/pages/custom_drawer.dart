import 'dart:math';
import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomateen/providers/user_provider.dart';

class CustomDrawer extends StatefulWidget {
  final List<Widget> pages;

  const CustomDrawer({
    Key? key,
    required this.pages,
  }) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _modalController;
  final double maxSlide = 200;
  final double minDragStartEdge = 60;
  late double maxDragStartEdge;
  bool _canBeDragged = false;
  int _selectedItemIndex = 0;

  @override
  void initState() {
    super.initState();

    maxDragStartEdge = maxSlide - 16;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _modalController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      animationBehavior: AnimationBehavior.preserve,
    );
  }

  void close() => _animationController.reverse();
  void open() => _animationController.forward();
  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();
  void toggleModal() => _modalController.isDismissed
      ? _modalController.forward()
      : _modalController.reverse();

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = _animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / maxSlide;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    double _kMinFlingVelocity = 100.0;

    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  @override
  void dispose() {
    _modalController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _user = Provider.of<UserProvider>(context).user;

    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (content, _) {
          return Stack(
            children: [
              Transform.translate(
                offset:
                    Offset(maxSlide * (_animationController.value - 1) - 16, 0),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(pi / 2 * (1 - _animationController.value)),
                  alignment: Alignment.centerRight,
                  child: Container(
                    color: _theme.colorScheme.secondary,
                    width: MediaQuery.of(context).size.width * 0.55,
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.18,
                        horizontal: 30),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          right: 0,
                          child: TextButton(
                            onPressed: close,
                            child: Text(
                              "Close",
                              style: _theme.textTheme.button?.copyWith(
                                color: _theme.colorScheme.onPrimary
                                    .withOpacity(0.9),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                close();

                                Future.delayed(
                                    const Duration(milliseconds: 500),
                                    () => {
                                          setState(() {
                                            _selectedItemIndex = 0;
                                          })
                                        });
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.home_max_rounded,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Home",
                                    style: _theme.textTheme.headline6?.copyWith(
                                        color: _theme.colorScheme.onPrimary),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                close();

                                Future.delayed(
                                    const Duration(milliseconds: 500),
                                    () => {
                                          setState(() {
                                            _selectedItemIndex = 1;
                                          })
                                        });
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.favorite,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Favorites",
                                    style: _theme.textTheme.headline6?.copyWith(
                                        color: _theme.colorScheme.onPrimary),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                close();

                                Future.delayed(
                                    const Duration(milliseconds: 500),
                                    () => {
                                          setState(() {
                                            _selectedItemIndex = 2;
                                          })
                                        });
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.alarm,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Orders",
                                    style: _theme.textTheme.headline6?.copyWith(
                                        color: _theme.colorScheme.onPrimary),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                close();

                                Future.delayed(
                                    const Duration(milliseconds: 500),
                                    () => {
                                          setState(() {
                                            _selectedItemIndex = 3;
                                          })
                                        });
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.shopping_cart,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Cart",
                                    style: _theme.textTheme.headline6?.copyWith(
                                        color: _theme.colorScheme.onPrimary),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              IgnorePointer(
                ignoring: _animationController.isCompleted,
                child: BackdropFilter(
                  filter: ImageFilter.blur(),
                  child: Transform.translate(
                    offset: Offset(maxSlide * _animationController.value, 0),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(-pi / 1.9 * _animationController.value * 0.7),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: _theme.colorScheme.primaryVariant),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: open,
                                  icon: Icon(
                                    Icons.menu,
                                    size: 30,
                                    color: _theme.colorScheme.onSurface,
                                  ),
                                ),
                                IconButton(
                                  onPressed: toggleModal,
                                  icon: Icon(
                                    Icons.account_circle_rounded,
                                    size: 30,
                                    color: _theme.colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                PageTransitionSwitcher(
                                  transitionBuilder: (child, primaryAnimation,
                                      secondaryAnimation) {
                                    return SharedAxisTransition(
                                      animation: primaryAnimation,
                                      secondaryAnimation: secondaryAnimation,
                                      transitionType:
                                          SharedAxisTransitionType.horizontal,
                                      child: child,
                                    );
                                  },
                                  child: widget.pages[_selectedItemIndex],
                                ),
                                Positioned(
                                  right: 0,
                                  child: AnimatedBuilder(
                                    animation: _modalController,
                                    builder: (ctx, child) {
                                      return Transform.translate(
                                        offset:
                                            Offset(0, _modalController.value),
                                        child: Transform(
                                          alignment:
                                              FractionalOffset.centerRight,
                                          transform: Matrix4.identity()
                                            ..translate(
                                                _animationController.value * 50,
                                                _animationController.value * 50)
                                            ..scale(_modalController.value),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                100,
                                            height:
                                                300 * _modalController.value,
                                            decoration: BoxDecoration(
                                              color: _theme.colorScheme.surface,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 5.0,
                                                ),
                                                BoxShadow(
                                                  color: Colors.white,
                                                  offset: Offset(0.0, 0.0),
                                                  blurRadius: 0.0,
                                                  spreadRadius: 0.0,
                                                ), //
                                              ],
                                            ),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Profile Page",
                                                    style: _theme
                                                        .textTheme.headline5
                                                        ?.copyWith(
                                                            color:
                                                                Colors.black),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Text(
                                                    _user!.name,
                                                    style: _theme
                                                        .textTheme.headline6
                                                        ?.copyWith(
                                                            color:
                                                                Colors.black),
                                                  ),
                                                  Text(
                                                    _user.email,
                                                    style: _theme
                                                        .textTheme.headline6
                                                        ?.copyWith(
                                                            color:
                                                                Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

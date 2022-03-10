import 'package:flutter/material.dart';

class UserReviewComponent extends StatelessWidget {
  final String name;
  final String review;

  const UserReviewComponent({
    Key? key,
    required this.name,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black), 
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: _theme.textTheme.headline6,),
          Text(review, style: _theme.textTheme.bodyText2,),
        ],
      ),
    );
  }
}

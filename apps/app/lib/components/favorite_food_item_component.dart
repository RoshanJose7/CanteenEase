import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomateen/providers/user_provider.dart';

class FavoriteFoodItemComponent extends StatelessWidget {
  final String id;
  final String name;
  final String imgUrl;
  final double price;
  final int rating;

  const FavoriteFoodItemComponent({
    Key? key,
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.price,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context);
    final _theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: _theme.textTheme.headline6!,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Rs $price",
                  style: _theme.textTheme.bodyText2!,
                ),
                const SizedBox(height: 5),
                IconButton(
                  onPressed: () => _user.toggle_fav(id, false),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
            CachedNetworkImage(
              imageUrl: imgUrl,
              width: 150,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/db/database_provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/utils/config.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
          future: provider.isFavorite(restaurant.id!),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                    arguments: restaurant);
              },
              child: Column(children: [
                Container(
                  margin: EdgeInsets.all(16),
                  child: Row(children: [
                    Hero(
                        tag: restaurant.id!,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              Config.IMAGE_SMALL_URL + restaurant.pictureId!,
                              fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                            ))),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(restaurant.name!,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: isFavorite
                                        ? IconButton(
                                            icon: Icon(Icons.favorite),
                                            color: Colors.orange,
                                            onPressed: () {
                                              provider.removeFavorite(
                                                  restaurant.id!);
                                            },
                                          )
                                        : IconButton(
                                            icon: Icon(Icons.favorite_border),
                                            color: Colors.grey,
                                            onPressed: () {
                                              provider.addFavorite(restaurant);
                                            },
                                          ),
                                  ),
                                ),
                              ],
                            ),
                            Text(restaurant.description!,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyText2,
                                maxLines: 4)
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ]),
            );
          });
    });
  }
}

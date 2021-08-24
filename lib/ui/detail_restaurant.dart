import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/config.dart';
import 'package:restaurant_app/utils/string_resource.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class DetailRestaurantPage extends StatelessWidget {
  Widget _buildList(BuildContext context) {
    return Consumer2<RestaurantProvider, PreferencesProvider>(
        builder: (context, restaurantProvider, preferenceProvider, _) {
      var restaurant;
      if (restaurantProvider.detailRestaurant != null) {
        restaurant = restaurantProvider.detailRestaurant!.restaurantDetail;
      }
      if (restaurantProvider.state == ResultState.Loading) {
        return Center(child: Lottie.asset('assets/json/loading.json'));
      } else if (restaurantProvider.state == ResultState.HasData) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: Config.IMAGE_LARGE_URL + restaurant.pictureId,
                child: Image.network(
                    Config.IMAGE_LARGE_URL + restaurant.pictureId),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                      color: preferenceProvider.isDarkTheme
                          ? Color(0xff303030)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 0.1,
                            color: preferenceProvider.isDarkTheme
                                ? Color(0xff303030)
                                : Colors.grey)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10, bottom: 6.0),
                        child: Text(
                          restaurant.name,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(6.0),
                        child: Row(children: <Widget>[
                          Icon(
                            Icons.place,
                            color: secondaryColor,
                          ),
                          Text(
                            "${restaurant.address}, ${restaurant.city}",
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ]),
                      ),
                      Container(
                        padding: EdgeInsets.all(6.0),
                        child: Row(
                          children: <Widget>[
                            RatingBar.builder(
                              initialRating: restaurant.rating!.toDouble(),
                              minRating: 1,
                              itemSize: 20,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            Text(
                              restaurant.rating.toString(),
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          restaurant.description!,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              menuItem(context, restaurant, Config.IMAGE_DRINK),
              menuItem(context, restaurant, Config.IMAGE_FOOD),
            ],
          ),
        );
      } else if (restaurantProvider.state == ResultState.Error) {
        return Center(
          child: Text(StringTranslation.errorMessage),
        );
      } else {
        return Center(
          child: Text(''),
        );
      }
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant App'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Restaurant App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  String getImage(String menuType) {
    List<String> foodImages = [
      "assets/images/food_1.png",
      "assets/images/food_2.png",
      "assets/images/food_3.png",
      "assets/images/food_4.png"
    ];
    List<String> drinkImages = [
      "assets/images/drink_1.png",
      "assets/images/drink_2.png",
      "assets/images/drink_3.png",
      "assets/images/drink_4.png"
    ];
    Random random = new Random();
    int idx = random.nextInt(4);
    switch (menuType) {
      case Config.IMAGE_DRINK:
        return drinkImages[idx];
      case Config.IMAGE_FOOD:
        return foodImages[idx];
    }
    return foodImages[0];
  }

  menuItem(BuildContext context, RestaurantDetail result, String menuType) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(10),
            child: Row(children: [
              Icon(
                menuType == Config.IMAGE_FOOD
                    ? Icons.fastfood
                    : Icons.emoji_food_beverage,
                color: secondaryColor,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  menuType == Config.IMAGE_FOOD
                      ? StringTranslation.foodTitle
                      : StringTranslation.drinkTitle,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ])),
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          padding: EdgeInsets.only(left: 4.0, bottom: 10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: menuType == Config.IMAGE_FOOD
                ? result.menus!.foods.length
                : result.menus!.drinks.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(bottom: 5, top: 5),
                width: MediaQuery.of(context).size.width * 0.3,
                child: Card(
                  //margin: EdgeInsets.all(10),
                  color: Colors.orangeAccent,
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.all(6),
                      child: Image.asset(
                        getImage(menuType),
                        width: 90,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: Center(
                        child: Text(
                          menuType == Config.IMAGE_FOOD
                              ? result.menus!.foods[index].name
                              : result.menus!.drinks[index].name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                  ]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

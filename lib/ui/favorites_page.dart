import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/db/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/string_resource.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class FavoritesPage extends StatelessWidget {
  static const routeName = '/favorites';
  static const String favoriteTitle = 'Favorites';

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(favoriteTitle),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(favoriteTitle),
      ),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      if (provider.state == ResultState.HasData) {
        return Material(
            child: ListView.builder(
                itemCount: provider.favorites.length,
                itemBuilder: (context, index) {
                  return CardRestaurant(restaurant: provider.favorites[index]);
                }));
      } else {
        return Material(
          child: Container(
            padding: EdgeInsets.all(80),
            child: Column(children: [
              Center(child: Lottie.asset('assets/json/empty.json')),
              Text(
                StringTranslation.emptyData,
                style: Theme.of(context).textTheme.bodyText1,
              )
            ]),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}

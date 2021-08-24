import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/string_resource.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';
import 'package:restaurant_app/widgets/custom_appbar.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
      create: (_) => RestaurantProvider().getRestaurant(),
      child: CustomScrollView(
        slivers: [
          Consumer2<RestaurantProvider, PreferencesProvider>(
              builder: (context, provider, preferenceProvider, _) {
            return SliverPersistentHeader(
              delegate: CustomAppbar(
                  expandedHeight: 200.0,
                  provider: provider,
                  preferencesProvider: preferenceProvider),
            );
          }),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
          Consumer<RestaurantProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.Loading) {
                return SliverFillRemaining(
                  child:
                      Center(child: Lottie.asset('assets/json/loading.json')),
                );
              } else if (state.state == ResultState.HasData) {
                return SliverList(
                    delegate: SliverChildListDelegate(state
                        .searchRestaurant!.restaurants
                        .map((restaurant) =>
                            CardRestaurant(restaurant: restaurant))
                        .toList()));
              } else if (state.state == ResultState.Error) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(StringTranslation.errorMessage),
                  ),
                );
              } else {
                return SliverFillRemaining(
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
            },
          )
        ],
      ),
    ));
  }
}

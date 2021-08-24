import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/favorites_page.dart';
import 'package:restaurant_app/ui/settings_page.dart';
import 'package:restaurant_app/utils/string_resource.dart';
import 'package:restaurant_app/widgets/curve_painter.dart';

class CustomAppbar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  RestaurantProvider provider;
  PreferencesProvider preferencesProvider;

  CustomAppbar(
      {required this.expandedHeight,
      required this.provider,
      required this.preferencesProvider});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
            color: preferencesProvider.isDarkTheme
                ? Color(0xff303030)
                : Colors.white,
            child: CustomPaint(
              painter: CurvePainter(),
            )),
        Positioned(
          top: 0,
          right: 16,
          child: SafeArea(
            child: IconButton(
              icon: Icon(Icons.settings),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingPage()));
              },
            ),
          ),
        ),
        Positioned(
          bottom: 70,
          left: 20,
          right: 20,
          child: Text(
            greetingTime(),
            style: Theme.of(context).textTheme.overline,
          ),
        ),
        Positioned(
          bottom: -5,
          left: 16,
          right: 16,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Row(
              children: [
                Card(
                  elevation: 10,
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 100,
                    child: Form(
                      child: Container(
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length >= 3) {
                              provider.doSearch(value);
                            } else if (value.length < 1) {
                              provider.doSearch("");
                              FocusScope.of(context).unfocus();
                            }
                          },
                          decoration: InputDecoration(
                            hintText: StringTranslation.searchHint,
                            suffixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: IconButton(
                      icon: Icon(Icons.favorite),
                      color: Colors.orange,
                      onPressed: () {
                        Navigator.pushNamed(context, FavoritesPage.routeName);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  String greetingTime() {
    DateTime now = new DateTime.now();
    int hour = now.hour;
    if (hour >= 0 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 16) {
      return "Good Afternoon";
    } else if (hour >= 16 && hour < 21) {
      return "Good Evening";
    } else {
      return "Good Night";
    }
  }
}

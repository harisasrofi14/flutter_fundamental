import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/string_resource.dart';
import 'package:restaurant_app/widgets/curve_painter.dart';

class CustomAppbar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  RestaurantProvider provider;

  CustomAppbar({required this.expandedHeight, required this.provider});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
            color: Colors.white,
            child: CustomPaint(
              painter: CurvePainter(),
            )),
        Positioned(
          bottom: 85,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              StringTranslation.appTitle,
              style: Theme.of(context).textTheme.headline6,
            ),
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
                    width: MediaQuery.of(context).size.width * 0.9,
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
                )
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
}

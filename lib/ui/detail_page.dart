import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: restaurant.pictureId,
                child: Image.network(restaurant.pictureId)),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: Row(children: <Widget>[
                      Icon(Icons.place),
                      Text(
                        restaurant.city,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ]),
                  ),
                  Container(
                      padding: EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          RatingBar.builder(
                            initialRating: restaurant.rating.toDouble(),
                            minRating: 1,
                            itemSize: 20,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
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
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      restaurant.description,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Divider(color: Colors.black),
                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      "Drink",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    padding: EdgeInsets.only(left: 4.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurant.menus.drinks.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Card(
                            color: Colors.amberAccent,
                            child: Center(
                              child: Text(
                                restaurant.menus.drinks[index].name,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 4.0, top: 15.0),
                    child: Text(
                      "Food",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    padding: EdgeInsets.only(left: 4.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurant.menus.foods.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Card(
                            color: Colors.amberAccent,
                            child: Center(
                              child: Text(
                                restaurant.menus.foods[index].name,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

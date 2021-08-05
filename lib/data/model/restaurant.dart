import 'dart:convert';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late num rating;
  late Menus menus;

  Restaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,
      required this.menus});

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = restaurant['id'];
    name = restaurant['name'];
    description = restaurant['description'];
    pictureId = restaurant['pictureId'];
    city = restaurant['city'];
    rating = restaurant['rating'];
    menus = new Menus.fromJson(restaurant['menus']);
  }
}

class Menus {
  late List<Food> foods;
  late List<Drink> drinks;

  Menus(this.foods, this.drinks);

  Menus.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = <Food>[];
      json['foods'].forEach((v) {
        foods.add(new Food.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      drinks = <Drink>[];
      json['drinks'].forEach((v) {
        drinks.add(new Drink.fromJson(v));
      });
    }
  }
}

class Food {
  late String name;

  Food({required this.name});

  Food.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}

class Drink {
  late String name;

  Drink({required this.name});

  Drink.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }
  final List parsed = jsonDecode(json);
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}

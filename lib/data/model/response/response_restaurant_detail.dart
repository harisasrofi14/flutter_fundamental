import 'dart:convert';

import '../restaurant_detail.dart';

RestaurantDetailResult restaurantDetailResultFromJson(String str) =>
    RestaurantDetailResult.fromJson(json.decode(str));

String restaurantDetailResultToJson(RestaurantDetailResult data) =>
    json.encode(data.toJson());

class RestaurantDetailResult {
  RestaurantDetailResult({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  Restaurant restaurant;

  factory RestaurantDetailResult.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailResult(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };
}

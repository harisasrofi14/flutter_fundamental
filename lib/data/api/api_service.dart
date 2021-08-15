import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/response/response_restaurant_detail.dart';
import 'package:restaurant_app/data/model/response/response_restaurant_search.dart';
import 'package:restaurant_app/utils/config.dart';
import 'package:restaurant_app/utils/string_resource.dart';

class ApiService {
  Future<RestaurantDetailResult> restaurantDetail(String id) async {
    final response = await http.get(Uri.parse(Config.BASE_URL + "detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(StringTranslation.exceptionMessage);
    }
  }

  Future<RestaurantSearchResult> search({String query = ""}) async {
    try {
      final response =
          await http.get(Uri.parse(Config.BASE_URL + 'search?q=$query'));
      if (response.statusCode == 200) {
        return RestaurantSearchResult.fromJson(json.decode(response.body));
      } else {
        throw Exception(StringTranslation.exceptionMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

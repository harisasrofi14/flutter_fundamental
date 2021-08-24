import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/response/response_restaurant_detail.dart';
import 'package:restaurant_app/data/model/response/response_restaurant_search.dart';
import 'package:restaurant_app/utils/string_resource.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  RestaurantDetailResult? _restaurantDetailResult;
  RestaurantSearchResult? _restaurantSearchResult;

  String _message = '';
  String _query = "";
  ResultState? _state;

  String get message => _message;

  RestaurantDetailResult? get detailRestaurant => _restaurantDetailResult;

  RestaurantSearchResult? get searchRestaurant => _restaurantSearchResult;

  ResultState? get state => _state;

  RestaurantProvider getDetailRestaurant(String id) {
    _fetchDetailRestaurant(id);
    return this;
  }

  RestaurantProvider getRestaurant() {
    _fetchRestaurant();
    return this;
  }

  void doSearch(String query) {
    _query = query;
    _fetchRestaurant();
  }

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.restaurantDetail(id);

      if (restaurant.restaurantDetail.id != null) {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantDetailResult = restaurant;
      } else {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = StringTranslation.emptyData;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> _fetchRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final response = await apiService.search(query: _query);
      if (response.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantSearchResult = response;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

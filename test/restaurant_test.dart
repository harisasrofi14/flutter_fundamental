import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/response/response_restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

import 'restaurant_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  group('Restaurant Test', () {
    late ApiService apiService;
    late Restaurant restaurant;
    late RestaurantDetail restaurantDetail;

    setUp(() {
      apiService = MockApiService();
      restaurant = Restaurant(
          id: "abc123",
          name: "Mock Restaurant",
          description: "Testing Restaurant",
          pictureId: "p1",
          city: "Jakarta",
          rating: 4.0);
      restaurantDetail = RestaurantDetail(
          id: "abc123",
          name: "Mock Restaurant",
          description: "Testing Restaurant",
          pictureId: "p1",
          city: "Jakarta",
          rating: 4.0);
    });

    test('Should success parsing json', () {
      var result = Restaurant.fromJson(restaurant.toJson());

      expect(result.id, result.id);
    });

    test("Should return restaurant detail from API", () async {
      when(apiService.restaurantDetail(restaurant.id!)).thenAnswer((_) async {
        return RestaurantDetailResult(
          error: false,
          message: 'success',
          restaurantDetail: restaurantDetail,
        );
      });
      expect(await apiService.restaurantDetail(restaurant.id!),
          isA<RestaurantDetailResult>());
    });
  });
}

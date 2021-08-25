import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

@GenerateMocks([ApiService])
void main() {
  group('Restaurant Test', () {
    late Restaurant restaurant;

    setUp(() {
      restaurant = Restaurant(
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
  });
}

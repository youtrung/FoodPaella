import 'dart:convert';

import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/services/api_services.dart';

class FoodRepository {
  static List<Food> parseResponses(String resp) {
    final  parsed=json.decode(resp).cast<Map<String,dynamic>>();
    return parsed.map<Food>((json)=>Food.fromJSON(json)).toList();
  }

  static APIService<List<Food>> load() {
    return APIService(
        url: Uri.http(baseAPI,"/api/foods"),
        parse: (response) {
          final foods = parseResponses(response.body);
          return foods;
        }
    );
  }
}
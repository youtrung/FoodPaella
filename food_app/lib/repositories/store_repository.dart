import 'dart:convert';

import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/services/api_services.dart';

class StoreRepository {
  static List<Store> parseResponses(String resp) {
    final  parsed=json.decode(resp).cast<Map<String,dynamic>>();

   return parsed.map<Store>((json)=>Store.fromJSON(json)).toList();
  }

  static APIService<List<Store>> load() {
    return APIService(
        url: Uri.http(baseAPI,"/api/stores"),
        parse: (response) {
          final stores = parseResponses(response.body);
          return stores;
        }
    );
  }
  static APIService<List<Store>> getFavoriteStores(CustomerModel? customerModel) {
    return APIService(
        url: Uri.http(baseAPI,"/api/customer/getFavoriteStores"),
        body: customerModel,
        parse: (response) {
          final stores = parseResponses(response.body);
          return stores;
        }
    );
  }


}
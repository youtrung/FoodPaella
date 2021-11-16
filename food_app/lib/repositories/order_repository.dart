import 'dart:convert';
import 'dart:math';

import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/services/api_services.dart';

class OrderRepository {
  static OrderModel parseResponses(String resp) {
    final order = OrderModel.fromJSON(jsonDecode(resp));
    return order;
  }

  static  List<OrderModel> parseListResponses(String resp) {
    final  parsed=json.decode(resp).cast<Map<String,dynamic>>();
    return parsed.map<OrderModel>((json)=>OrderModel.fromJSON(json)).toList();
  }



  static APIService<OrderModel> postOrder(OrderModel? orderModel) {
    return APIService(
        url: Uri.http(baseAPI,"/api/orders"),
        body: orderModel,
        parse: (response) {
          var data=parseResponses(response.body);
          return  data;
        }
    );
  }
  static APIService<List<OrderModel>> getOrderById(String userId) {
    return APIService(
        url: Uri.http(baseAPI,"api/customer/getOrders/$userId"),
        parse: (response) {
          var data=parseListResponses(response.body);
          return  data;
        }
    );
  }

  static APIService<List<OrderModel>> postOrderDayToDay(String? userId,DateTime? startDate,DateTime? endDate) {
    Map data = {
      "customer_id":userId,
      "startDay":startDate!.toIso8601String(),
      "endDay":endDate!.toIso8601String()
    };
    return APIService(
        url: Uri.http(baseAPI,"api/customer/filterOrdersDayToDay"),
        body:data,
        parse: (response) {
          var data=parseListResponses(response.body);
          return  data;
        }
    );
  }




}
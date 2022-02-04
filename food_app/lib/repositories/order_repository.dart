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

  static APIService<String> postNOti(String? store) {
    return APIService(
        url: Uri.https(baseGoogle,"fcm/send"),
        body:{
          "notification": {
            "title": "DON HANG MOI",
            "body": {
              "store_id":"$store",
              "content": "XIN VUI LONG KIEM TRA DON HANG"
            }
          },
          "to": "f5pfm_DdENmkujqpj8m0wN:APA91bE2dbk5H89bHiBB4oqaAA0C6aDEG1s3od_nyfnIlWmr0Bbx7B9nD92Ax4kWtOuDKKide3RcxZG6f7mBUgRv7ZwwIfDuoRApQDPO6FJyw9L1cElxL4JAvjrSm-ew5m5a6qOSj3Vh"
        },
        parse: (response) {
          return  response.toString();
        }
    );
  }




}
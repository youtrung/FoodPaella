import 'food_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class OrderModel {
  DateTime? createdAt;
  DateTime? updatedAt;
  String? storeId;
  String? customerId;
  double? totalMoney;
  String? status;
  String? couponId;
  List<Food>? foods=[];
  OrderModel({
   this.createdAt,
    this.updatedAt,
    this.storeId,
    this.customerId,
    this.totalMoney=0,
    this.status="Đang giao",
    this.foods,
    this.couponId
});
  factory OrderModel.fromJSON(Map<String,dynamic> jsonMap) {
    var foodOrders=List<Food>.from(jsonMap["food_orders"].map((x) => Food.OrderfromJSON(x)));
    final data=OrderModel(
        createdAt: DateTime.parse(jsonMap["createdAt"]),
        updatedAt:DateTime.parse(jsonMap["updatedAt"]),
        storeId: jsonMap["store_id"],
        customerId: jsonMap["customer_id"],
        totalMoney: jsonMap["total_money"].toDouble(),
        status: jsonMap["status"],
        foods:foodOrders,
        couponId: jsonMap["coupon_id"] ?? ""
    );
    return data;
  }

  Map<String,dynamic> toJson () {
    return {
      "store_id":storeId,
      "customer_id":customerId,
      "total_money":totalMoney!.toInt(),
      "status":status,
      "food_orders":List<dynamic>.from(foods!.map((x) => x.OrderToJSON())),
      "coupon_id":couponId ?? ""
    };

  }

}


import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class RateModel {
  String? store_id;
  String? customer_id;
  double? rate;
  RateModel({this.store_id,this.customer_id,this.rate});

  factory RateModel.fromJSON(Map<String,dynamic> jsonMap) {
    final data=RateModel(
      store_id: jsonMap["store_id"],
      customer_id:jsonMap["customer_id"],
        rate: jsonMap["rate"],
    );
    return data;
  }
  Map<String,dynamic> toJson () {
    return {
      "store_id":store_id,
      "customer_id":customer_id,
      "rate":rate
    };

  }

}

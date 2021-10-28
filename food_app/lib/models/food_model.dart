import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class Food {
  String? id;
  String? image;
  String? name;
  String? typeOfFood;
  String? status;
  int quantity;
  int? price;
  Food({
    this.id,
    this.name,
    this.typeOfFood,
    this.price,
    this.quantity=0,
    this.image,
    this.status
});
  factory Food.fromJSON(Map<String,dynamic> jsonMap) {
    final data=Food(
        id: jsonMap["_id"],
        name: jsonMap["name"],
        typeOfFood: jsonMap["type_of_food"],
        price: jsonMap["price"],
        status: jsonMap["status"],
        image:jsonMap["image"]
    );
    return data;
  }

  factory Food.OrderfromJSON(Map<String,dynamic> jsonMap) {
    final data=Food(
        id: jsonMap["food_id"],
        price: jsonMap["price"],
        quantity: jsonMap["quantity"],
    );
    return data;
  }


  Map<String,dynamic> toJSON() => {
    "_id":id,
    "name": name,
    "status": status,
    "type_of_food": typeOfFood,
    "image": image,
    "price":price,
    "quantity":quantity
  };

  Map<String,dynamic> OrderToJSON() => {
    "food_id":id,
    "price":price,
    "quantity":quantity
  };



}


class Food {
  int? id;
  String? imageFood;
  String? nameFood;
  String? description;
  String? category;
  int quantity;
  double? price;
  Food({
   this.id,this.nameFood,this.description,this.category,this.price,this.quantity=0,this.imageFood
});
  factory Food.fromJSON(Map<String,dynamic> jsonMap) {
    var price=double.parse(jsonMap["price"] ?? 0.0 as String);
    var quantity=int.parse(jsonMap["quantity"] ?? 0.0 as String);
    final data=Food(
      id: jsonMap["id"],
      nameFood: jsonMap["food_name"],
      description: jsonMap["description"],
      category: jsonMap["category"],
      price: price,
      quantity: quantity,
      imageFood:jsonMap["imageFood"]
    );
    return data;
  }
}
import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class Store {
  String? id;
  String? name;
  String? status;
  List<String>? foods;
  String? image;
  List<Review>? reviews;
  Contact? contact;

  Store({this.id,this.name,
    this.image,this.contact,this.foods,this.reviews,this.status
  }
  );
  factory Store.initial() {
    return Store();
  }

  factory Store.fromJSON(Map<String,dynamic> jsonMap){
    var reviews=List<Review>.from(jsonMap["reviews"].map((x) => Review.fromJson(x)));
    var foods=List<String>.from(jsonMap["Foods"].map((x) => x));
    final data=Store(
        id:jsonMap["_id"],
        name: jsonMap["name"],
        image: jsonMap["image"],
        status: jsonMap["status"],
        contact: Contact.fromJSON(jsonMap["contact"]),
        foods: foods,
        reviews: reviews
    );
    return data;
  }

  Map<String,dynamic> toJSON() => {
    "contact": contact,
    "_id": id,
    "name": name,
    "status": status,
    "Foods": List<String>.from(foods!.map((x) => x)),
    "image": image,
    "reviews": List<Review>.from(reviews!.map((x) => x.toJson())),

  };

}

class Review {
  Review({
    this.customerId,
    this.rate,
    this.id,
  });

  String? customerId;
  double? rate;
  String? id;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    customerId: json["customer_id"],
    rate: json["rate"].toDouble(),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "customer_id": customerId,
    "rate": rate,
    "_id": id,
  };

}

class Contact {
  String? phone;
  String? email;
  Address? address;
  Contact({
    this.phone,this.email,this.address
});

  factory Contact.fromJSON(Map<String,dynamic> jsonMap) {
    Address address=Address.fromJSON(jsonMap["address"]);
    final data=Contact(
      phone: jsonMap["phone"],
      email: jsonMap["email"],
      address: address,
    );
    return data;
  }

}
class Address {
  String? street;
  String? city;
  String? district;
  List<Activity>? activity;

  Address({
    this.street,this.city,this.district,this.activity
});
  factory Address.fromJSON(Map<String,dynamic> jsonMap) {
    var times=jsonMap["activity"] as List;
    List<Activity> listActivity=times.
    map<Activity>((i)=> Activity.fromJSON(i)).toList();

    final data=Address(
      district: jsonMap["district"],
      street:jsonMap["street"],
      city: jsonMap["city"],
      activity:listActivity
    );
    return data;
  }

}
class Activity{
  String? day;
  DateTime? open;
  DateTime? close;
  Activity({
    this.day,this.open,this.close
});
  factory Activity.fromJSON(Map<String,dynamic> jsonMap) {
    final data=Activity(
      day: jsonMap["day"],
      open: DateTime.parse(jsonMap["open"]),
      close: DateTime.parse(jsonMap["close"]),
    );
    return data;
  }

}
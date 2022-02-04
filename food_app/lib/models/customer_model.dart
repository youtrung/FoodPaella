import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CustomerModel {
  String? id;
  String? name;
  String? password;
  String? avatar;
  List<String>? loveStoreIds;
  String? phone;
  String? email;
  Address? address;
  String? code;
  CustomerModel({
    this.id,
    this.name,
    this.password,
    this.avatar,
    this.loveStoreIds,
    this.phone,
    this.email,
    this.address,
    this.code
  }
  );
  factory CustomerModel.initial() { // class initial
    return CustomerModel(
      avatar: "",
      loveStoreIds: <String>[],
      phone:"",
      code: "",
      address: Address.initial(),
    );
  }

  CustomerModel copyWith({String? id,String? name,String? password,String? avartar,List<String>? loveStoreIds,String? phone,
    String? email,Address? address,}) {
      return CustomerModel(
        id:id ?? this.id,
        name:name?? this.name,
        password: password ?? this.password,
        avatar: avartar ?? this.avatar,
        loveStoreIds: loveStoreIds ?? this.loveStoreIds,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        address: address ?? this.address
      );
  }


  factory CustomerModel.fromJSON(Map<String,dynamic> jsonMap) {
    Address address=Address.fromJSON(jsonMap["address"]);
    var listStore=List<String>.from(jsonMap["love_store_ids"].map((x) => x));
    final data=CustomerModel(
      address: address,
      id: jsonMap["_id"],
      name: jsonMap["name"],
      password: jsonMap["password"],
      avatar: jsonMap["avatar"],
      loveStoreIds:listStore,
      phone: jsonMap["phone"],
      email: jsonMap["email"],

    );
    return data;
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name":name,
      "password":password,
      "avatar":avatar,
      "love_store_ids":loveStoreIds,
      "phone":phone,
      "email":email,
      "address":address!.toJson()
    };
  }

}


class Address {
  String? street;
  String? ward;
  String? district;
  String? city;
  Address({this.street,this.ward,this.district,this.city});

  factory Address.initial() { // class initial
    return Address(
      street: "",
      ward: "",
      district: "",
      city: "",
    );
  }

  factory Address.fromJSON(Map<String,dynamic> jsonMap) {
    final data=Address(
      street: jsonMap["street"],
      ward: jsonMap["ward"],
      district: jsonMap["district"],
      city:jsonMap["city"]
    );
    return data;
  }


  Map<String, dynamic> toJson() {
    return {
      "street":street ?? "",
      "ward":ward ?? "",
      "district":district ?? "",
      "city":city ?? ""
    };
  }


}
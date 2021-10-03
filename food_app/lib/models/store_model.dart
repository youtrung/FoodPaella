



import 'food_model.dart';

class Store {
  int? id;
  String? nameStore;
  String? imageStore;
  double? rate;
  Contact? contact;
  List<Food>? foods;

  Store({this.id,this.nameStore,
    this.imageStore,this.rate,this.contact,this.foods
  }
  );

  factory Store.fromJSON(Map<String,dynamic> jsonMap){
    var foods=jsonMap["foods"] as List;
    List<Food> listFood=foods.map((e) => Food.fromJSON(e)).toList();
    final data=Store(
      id:jsonMap["id"],
      nameStore: jsonMap["name"],
      imageStore: jsonMap["image"],
      rate: jsonMap["rate"],
      contact: Contact.fromJSON(jsonMap["contact"]),
      foods:listFood
    );
    return data;
  }

}

class Contact {
  String? phone;
  String? email;
  List<Addresses>? addresses;
  Contact({
    this.phone,this.email,this.addresses
});

  factory Contact.fromJSON(Map<String,dynamic> jsonMap) {
    var _listAddresses=jsonMap["addresses"] as List;
    List <Addresses> listAddresses=_listAddresses.
    map((i)=>Addresses.fromJSON(i)).toList();
    final data=Contact(
      phone: jsonMap["phone"],
      email: jsonMap["email"],
      addresses: listAddresses,
    );
    return data;
  }

}

class Addresses {
  String? street;
  String? city;
  String? district;
  List<Activity_Time>? activityTime;

  Addresses({
    this.street,this.city,this.activityTime
});
  factory Addresses.fromJSON(Map<String,dynamic> jsonMap) {
    var times=jsonMap["activity_time"] as List;
    List<Activity_Time> listActivity=times.
    map((i)=> Activity_Time.fromJSON(i)).toList();

    final data=Addresses(
      street:jsonMap["street"],
      city: jsonMap["city"],
      activityTime:listActivity,
    );
    return data;
  }

}
class Activity_Time{
  String? day;
  DateTime? open;
  DateTime? close;
  Activity_Time({
    this.day,this.open,this.close
});
  factory Activity_Time.fromJSON(Map<String,dynamic> jsonMap) {
    final data=Activity_Time(
      day: jsonMap["day"],
      open: DateTime.parse(jsonMap["open"]),
      close: DateTime.parse(jsonMap["close"]),
    );
    return data;
  }

}
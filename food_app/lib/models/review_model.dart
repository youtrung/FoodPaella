import 'package:food_app/models/customer_model.dart';

class ReviewModel {
  CustomerModel? customerModel;
  String? storeId;
  double? rate;
  ReviewModel({this.customerModel,this.storeId,this.rate});
}
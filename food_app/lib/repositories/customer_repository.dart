import 'dart:convert';

import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/models/result_model.dart';
import 'package:food_app/services/api_services.dart';

class CustomerRepository {

static CustomerModel? parseResponses(String resp) {
  if (resp!="null") {
    final customer = CustomerModel.fromJSON(jsonDecode(resp));
    return customer;
  }else
      return null;
}

static ResultModel parseResultResponses(String resp) {
  final result = ResultModel.fromJSON(jsonDecode(resp));
  return result;
}

static APIService<CustomerModel?>? getCustomerById(String customerId) {
  return APIService(
      url: Uri.http(baseAPI,"/api/customers/$customerId"),
      parse: (response) {
        final customer = parseResponses(response.body);
        return customer;
      }
  );
}


static APIService<CustomerModel?> getCustomerByEmailAndPassword(CustomerModel? customerModel) {
  return APIService(
      url: Uri.http(baseAPI,"/api/loginCustomer"),
      body: customerModel,
      parse: (response) {
        final customer = parseResponses(response.body);
        return customer;
      }
  );
}

static APIService<String> saveToken(CustomerModel? customerModel) {
  return APIService(
      url: Uri.http(baseAPI,"/api/customer/sign-in"),
      body: customerModel,
      parse: (resp) {
        return resp.body;
      }
  );
}

static APIService<String> getToken(String? token) {
  return APIService(
      url: Uri.http(baseAPI,"/api/customer/sign-in/$token"),
      parse: (resp) {
        return resp.body;
      }
  );
}



static APIService<CustomerModel?> createCustomerWithEmailAndPassword(CustomerModel? customerModel) {
  return APIService(
    url: Uri.http(baseAPI,"/api/customers"),
    body: customerModel,
    parse: (response) {
      final customer = parseResponses(response.body);
      return customer;
    }
  );
}

static APIService<ResultModel> updateUser(CustomerModel? customerModel) {
  return APIService(
      url: Uri.http(baseAPI,"/api/customers/" + customerModel!.id.toString()),
      body: customerModel,
      parse: (response) {
        final result = parseResultResponses(response.body);
        return result;
      }
  );
}






}
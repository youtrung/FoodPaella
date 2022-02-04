import 'dart:convert';

import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/models/rate_model.dart';
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

static List<RateModel> parseRateResponses(String resp) {
  final  parsed=json.decode(resp).cast<Map<String,dynamic>>();
  return parsed.map<RateModel>((json)=>RateModel.fromJSON(json)).toList();
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
static APIService<ResultModel> commentStore(RateModel? rateModel) {
  return APIService(
      url: Uri.http(baseAPI,"/api/customer/reviewStore"),
      body:rateModel,
      parse: (response) {
        final result = parseResultResponses(response.body);
        return result;
      }
  );
}

static APIService<List<RateModel>> getReviewsStore(String? storeId) {
  return APIService(
      url: Uri.http(baseAPI,"/api/customer/getReviewsOfStore/$storeId"),
      parse: (response) {
        final result = parseRateResponses(response.body);
        return result;
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
static APIService<String?> forgotPassword(String? email) {
  return APIService(
      url: Uri.http(baseAPI,"/api/customer/forgotPassword"),
      body:{
        "email":email
      },
      parse: (response) {
        final result = json.decode(response.body);
        return result["message"];
      }
  );
}
static APIService<bool> checkVerificationCode(String? email,int code) {
  return APIService(
      url: Uri.http(baseAPI,"/api/customer/checkVerificationCode"),
      body:{
        "code":code,
        "email":email
      },
      parse: (response) {
        final result = json.decode(response.body);
        return result;
      }
  );
}

static APIService<String?> resetPassword(String? email,String? password) {
  return APIService(
      url: Uri.http(baseAPI,"/api/customer/resetPassword"),
      body:{
        "email":email,
        "password":password
      },
      parse: (response) {
        final result = json.decode(response.body);
        return result;
      }
  );
}





}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class APIService<T> {
  final Uri? url;
  final dynamic body;
  T Function(http.Response response)? parse;
  APIService({this.url, this.body, this.parse});
}
class APIWeb {
  Future<T> get<T>(APIService<T>? resource) async {
    String parsedData=Uri.decodeFull(resource!.url!.toString()).replaceAll(r'"', '');
    final response = await http.get(Uri.parse(parsedData));
    if(response.statusCode == 200) {
      return resource.parse!(response);
    } else {
      throw Exception(response.statusCode);
    }
  }
  Future<T?> post<T>(APIService<T?> resource) async {
    Map<String, String>  headers = {
      "Content-Type": "application/json",
    };
    final response = await http.post(resource.url!, body: jsonEncode(resource.body), headers: headers);
    if(response.statusCode == 200) {
      return resource.parse!(response);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<T?> postNoti<T>(APIService<T?> resource) async {
    Map<String, String>  headers = {
      "Content-Type": "application/json",
      "Authorization":"key=AAAAClRZ-5o:APA91bF8vQ81a6o_h_kVCIaWAmBuEb-KBn-uefzlIDS7zBSDgc8zQUSDRsG4K3Q9bP69W91xjDDI18XP7wZupTSv1UW_F2q_G4P15nuPlueqC8DxWzXOnsUQC79d7h7eaLzxHT9UAqwo",
    };
    final response = await http.post(resource.url!, body: jsonEncode(resource.body), headers: headers);
    if(response.statusCode == 200) {
      return resource.parse!(response);
    } else {
      throw Exception(response.statusCode);
    }
  }




  Future<T> put<T>(APIService<T> resource) async {
    Map<String, String>  headers = {
      "Content-Type": "application/json",
    };
    final response = await http.put(resource.url!, body: jsonEncode(resource.body), headers: headers);
    if(response.statusCode == 200) {
      return resource.parse!(response);
    } else {
      throw Exception(response.statusCode);
    }
  }

}
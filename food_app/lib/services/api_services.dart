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
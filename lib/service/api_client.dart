import 'dart:convert';
import 'package:http/http.dart' as http;
import '../global/global.dart';

class ApiClient {
  static Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (Global.bearerToken.isNotEmpty)
          'Authorization': 'Bearer ${Global.bearerToken}',
      };

  static Future<http.Response> get(String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: _headers,
    );
    return response;
  }

  static Future<http.Response> post(String url, {Map<String, dynamic>? body}) async {
    final response = await http.post(
      Uri.parse(url),
      headers: _headers,
      body: body != null ? jsonEncode(body) : null,
    );
    return response;
  }

  static Future<http.Response> put(String url, {Map<String, dynamic>? body}) async {
    final response = await http.put(
      Uri.parse(url),
      headers: _headers,
      body: body != null ? jsonEncode(body) : null,
    );
    return response;
  }

  static Future<http.Response> delete(String url) async {
    final response = await http.delete(
      Uri.parse(url),
      headers: _headers,
    );
    return response;
  }
}

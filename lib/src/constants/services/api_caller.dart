import 'dart:convert';
import 'package:http/http.dart' as http;

class APICaller {
  static final APICaller _instance = APICaller._internal();
  factory APICaller() => _instance;
  APICaller._internal();
  final String baseUrl = "http://192.168.1.26:8095/"; 
  static const Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final url = Uri.parse(baseUrl + endpoint);
      print('Calling API GET: $url with headers: ${headers ?? requestHeaders}');
      final response = await http.get(url, headers: headers ?? requestHeaders)
          .timeout(const Duration(seconds: 10));
      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      return _processResponse(response);
    } catch (e) {
      print('Error calling API for endpoint $endpoint: $e');
      throw Exception('Lỗi khi gọi API: $e');
    }
  }

  Future<dynamic> post(String endpoint, {Map<String, String>? headers, dynamic body}) async {
    try {
      final url = Uri.parse(baseUrl + endpoint);
      print('Calling API POST: $url with headers: ${headers ?? requestHeaders} and body: $body');
      final response = await http.post(
        url,
        headers: headers ?? requestHeaders,
        body: body != null ? jsonEncode(body) : null,
      ).timeout(const Duration(seconds: 10)); 
      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      return _processResponse(response);
    } catch (e) {
      print('Error calling API for endpoint $endpoint: $e');
      throw Exception('Lỗi khi gọi API: $e');
    }
  }

  dynamic _processResponse(http.Response response) {
    print('API Response: ${response.body}'); 
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        print('Error decoding JSON: $e');
        throw Exception('Lỗi phân tích dữ liệu JSON: $e');
      }
    } else {
      print('API Error: ${response.statusCode} - ${response.body}');
      throw Exception('Lỗi API: ${response.statusCode} - ${response.body}');
    }
  }
}
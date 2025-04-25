import 'package:http/http.dart' as http;

class HttpHelper {
  static Future<http.Response> requrestPOST(
      {required String url, required Object? body, required Map<String, String>? headers}) async {
    final response = await http.post(Uri.parse(url), body: body, headers: headers);
    return response;
  }

  static Future<http.Response> requestGET({required String url, required Map<String, String>? headers}) async {
    final response = await http.get(Uri.parse(url), headers: headers);
    return response;
  }

  static Future<http.Response> requestDELETE(
      {required String url, required Object? body, required Map<String, String>? headers}) async {
    final response = await http.delete(Uri.parse(url), body: body, headers: headers);
    return response;
  }
}

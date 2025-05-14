import 'dart:convert';
import 'package:alivechms/controllers/app_controller.dart';
import 'package:alivechms/main.dart';
import 'package:http/http.dart' as http;

class AppAPI {
  // BASE URL FOR API
  static const String baseURL = 'http://www.onechurch.com';

  // LIST OF API ENDPOINTS
  static final Map<String, String> urls = {
    'login': '$baseURL/auth/login',
    'getAllMembers': '$baseURL/members/all',
    'logout': '$baseURL/auth/logout',
    'getRecentMembers': '$baseURL/members/recent',
    'dashboardHighlights': '$baseURL/dashboard/highlights',
    'refreshToken': '$baseURL/auth/refresh',
  };

  // REQUEST METHOD FOR MAKING ALL REQUESTS
  Future<dynamic> request(
    String method,
    String url, [
    Map<String, dynamic> data = const {},
    Map<String, String> headers = const {},
  ]) async {
    try {
      // HTTP REQUEST OPTIONS
      final options = http.Request(method, Uri.parse(url));

      // CREATE THE HTTP HEADERS
      if (headers.isEmpty) {
        headers = Map<String, String>.from(options.headers);
        headers['Content-Type'] = 'application/json';
        headers['Authorization'] = 'Bearer ${AppController.userToken}';
      }

      // ADD IT TO THE HTTP OPTIONS
      options.headers.addAll(headers);

      // ENCODE THE REQUEST BODY
      options.body = jsonEncode(data);

      // SEND THE REQUEST VIA HTTP CLIENT()
      final res = await http.Client().send(options);

      // EXTRACT RESPONSE FROM RESPONSE STREAM
      final response = await http.Response.fromStream(res);

      // CHECK IF REQUEST WAS SUCCESSFUL
      if (response.statusCode >= 200) {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body);
        return decoded;
      } else if (response.statusCode == 401) {
        // Attempt to refresh token
        try {
          final refreshResponse = await refreshAccessToken();
          await aspBox.put('access_token', refreshResponse['access_token']);
          await aspBox.put('refresh_token', refreshResponse['refresh_token']);

          // Retry original request with new token
          final retryOptions = http.Request(method, Uri.parse(url));
          retryOptions.headers.addAll({
            ...headers,
            'Authorization': 'Bearer ${refreshResponse['access_token']}',
          });
          print("New Headers: ${retryOptions.headers}");
          retryOptions.body = jsonEncode(data);
          final retryRes = await http.Client().send(retryOptions);
          final retryResponse = await http.Response.fromStream(retryRes);

          if (retryResponse.statusCode >= 200 &&
              retryResponse.statusCode < 300) {
            final retryDecoded = jsonDecode(retryResponse.body);
            return retryDecoded;
          } else {
            throw Exception(
                "Retry failed: ${retryResponse.statusCode} - ${retryResponse.body}");
          }
        } catch (refreshError) {
          throw Exception("Token refresh failed: $refreshError");
        }
      } else {
        throw Exception(
            "Bad Request: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // LOG USERS IN
  Future<Map<String, dynamic>> login(
    String userName,
    String password,
  ) async {
    final res = await request(
      'post',
      urls['login']!,
      {
        'userid': userName,
        'passkey': password,
      },
    );
    return res as Map<String, dynamic>;
  }

  // FETCH ALL MEMBERS
  Future<List<dynamic>> getAllMembers() async {
    final accessToken = aspBox.get('access_token') as String? ?? '';
    final res = await request(
      'post',
      urls['getAllMembers']!,
      {},
      {'Authorization': 'Bearer $accessToken'},
    );
    print('getAllMembers Response Type: ${res.runtimeType}');
    return res is List<dynamic> ? res : (res['data'] as List<dynamic>);
  }

  // FETCH RECENT MEMBERS
  Future<List<dynamic>> getRecentMembers() async {
    final accessToken = aspBox.get('access_token') as String? ?? '';
    final res = await request(
      'get',
      urls['getRecentMembers']!,
      {},
      {'Authorization': 'Bearer $accessToken'},
    );
    print('getRecentMembers Response: $res');
    print('getRecentMembers Response Type: ${res.runtimeType}');
    return res is List<dynamic> ? res : (res['data'] as List<dynamic>);
  }

  // FETCH DASHBOARD HIGHLIGHTS
  Future<Map<String, dynamic>> getDashboardHighlights() async {
    final accessToken = aspBox.get('access_token') as String? ?? '';
    final res = await request(
      'get',
      urls['dashboardHighlights']!,
      {},
      {'Authorization': 'Bearer $accessToken'},
    );
    return res as Map<String, dynamic>;
  }

  // REFRESH ACCESS TOKEN
  Future<Map<String, dynamic>> refreshAccessToken() async {
    final refreshToken = aspBox.get('refresh_token') as String? ?? '';
    final res = await request(
      'post',
      urls['refreshToken']!,
      {'refresh_token': refreshToken},
    );
    return res as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> changePassword(String newPassword,
      String confPassword, String oldPassword, String userName) async {
    final res = await request('post', urls['passwordChange']!, {
      'newPassword': newPassword,
      'confPassword': confPassword,
      'oldPassword': oldPassword,
      'userName': userName
    });
    return res as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> resetPassword(String userName) async {
    final res =
        await request('post', urls['resetPassword']!, {'userName': userName});
    return res as Map<String, dynamic>;
  }
}

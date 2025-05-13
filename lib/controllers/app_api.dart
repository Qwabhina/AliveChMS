import 'dart:convert';

import 'package:http/http.dart' as http;

class AppAPI {
  // BASE URL FOR API
  static const String baseURL = 'http://www.onechurch.com';

  // LIST OF API ENDPOINTS
  static final Map<String, String> urls = {
    'login': '$baseURL/auth/login',
    'getAllMembers': '$baseURL/get-members.php',
    'passwordChange': '$baseURL/change_student_password',
    'saveCourseRegistration': '$baseURL/student_register_courses',
    'dropCourse': '$baseURL/drop_course',
    'resetPassword': '$baseURL/init_recover_password',
    'resetPasswordPhone': '$baseURL/reset_password_sms',
  };

  // REQUEST METHOD FOR MAKING ALL REQUESTS
  Future<Map<String, dynamic>> request(
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
        // headers['Authorization'] = 'Bearer ${AppController.userToken}';
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
        print(response.body);
        return jsonDecode(response.body);
      } else {
        // THROW EXCEPTION ON ERROR
        throw Exception("Bad Request: ${response.statusCode}");
      }
    } catch (e) {
      // THROW EXCEPTION ON ERROR
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
    return res;
  }

  // GET MOUNTED COURSES
  Future<Map<String, dynamic>> getAllMembers() async {
    final res = await request('post', urls['getAllMembers']!);
    return res;
  }

  Future<Map<String, dynamic>> changePassword(String newPassword,
      String confPassword, String oldPassword, String userName) async {
    final res = await request('post', urls['passwordChange']!, {
      'newPassword': newPassword,
      'confPassword': confPassword,
      'oldPassword': oldPassword,
      'userName': userName
    });
    return res;
  }

  Future<Map<String, dynamic>> resetPassword(String userName) async {
    final res =
        await request('post', urls['resetPassword']!, {'userName': userName});
    return res;
  }
}

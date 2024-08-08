import 'dart:convert';

import 'package:alivechms/controllers/app_controller.dart';
import 'package:http/http.dart' as http;

class AppAPI {
  // BASE URL FOR API
  // static const String baseURL = 'http://89.116.229.230:3002';
  static const String baseURL = 'https://smgt.aamusted.edu.gh';

  // static String baseURL = aspBox.get(
  //   'baseUrl',
  //   defaultValue: 'https://smgt.aamusted.edu.gh',
  // );

  // LIST OF API ENDPOINTS
  static final Map<String, String> urls = {
    'login': '$baseURL/student_login',
    'passwordChange': '$baseURL/change_student_password',
    'getMountedCourse': '$baseURL/get_student_mounted_courses',
    'saveCourseRegistration': '$baseURL/student_register_courses',
    'dropCourse': '$baseURL/drop_course',
    'resetPassword': '$baseURL/init_recover_password',
    'resetPasswordPhone': '$baseURL/reset_password_sms',
  };

  final Map<String, String> endpoints = {
    'login': 'student_login',
    'passwordChange': 'change_student_password',
    'getMountedCourse': 'get_student_mounted_courses',
    'saveCourseRegistration': 'student_register_courses',
    'dropCourse': 'drop_course',
    'resetPassword': 'init_recover_password',
    'resetPasswordPhone': 'reset_password_sms',
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
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        // THROW EXCEPTION ON ERROR
        throw Exception(
          'Error: ${response.statusCode} - ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      // THROW EXCEPTION ON ERROR
      throw Exception('Error: $e');
    }
  }

  // LOG USERS IN
  Future<Map<String, dynamic>> login(
    String indexNo,
    String password, {
    String endpoint = '',
  }) async {
    final res = await request(
      'post',
      endpoint.isNotEmpty ? endpoint : urls['login']!,
      {'indexNo': indexNo, 'password': password},
    );
    return res;
  }

  // GET MOUNTED COURSES
  Future<Map<String, dynamic>> getMountedCourses() async {
    final res = await request('post', urls['getMountedCourse']!);
    return res;
  }

  Future<Map<String, dynamic>> changePassword(String newPassword,
      String confPassword, String oldPassword, String indexNo) async {
    final res = await request('post', urls['passwordChange']!, {
      'newPassword': newPassword,
      'confPassword': confPassword,
      'oldPassword': oldPassword,
      'indexNo': indexNo
    });
    return res;
  }

  Future<Map<String, dynamic>> saveCourseRegistration(
    List<Map<String, dynamic>> data,
  ) async {
    final res =
        await request('post', urls['saveCourseRegistration']!, {'data': data});
    return res;
  }

  Future<Map<String, dynamic>> dropSavedCourse(
      Map<String, dynamic> data) async {
    final res = await request('post', urls['dropCourse']!, data);
    return res;
  }

  Future<Map<String, dynamic>> resetPassword(String indexNo) async {
    final res =
        await request('post', urls['resetPassword']!, {'indexNo': indexNo});
    return res;
  }

  Future<Map<String, dynamic>> resetPasswordPhone(
      String indexNo, String phone) async {
    final res = await request('post', urls['resetPasswordPhone']!,
        {'indexNo': indexNo, 'phone': phone});
    return res;
  }
}

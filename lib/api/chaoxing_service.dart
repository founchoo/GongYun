import 'dart:convert';

import 'package:gong_yun/api/data_storage_service.dart';
import 'package:gong_yun/model/schedule.dart';
import 'package:http/http.dart' as http;

class ChaoxingService {
  static const baseUrl = 'hbut.jw.chaoxing.com';

  static Future<void> getCalendar(String semesterYearAndNo) async {
    final response = await http.get(
        Uri.https(baseUrl, '/admin/system/zy/xlgl/getData/$semesterYearAndNo'));
    print(response.body);
  }

  static Future<List<Schedule>> getSchedule() async {
    final queryParameters = {
      'xnxq': '2023-2024-1', // Semester year and term
      'xhid': DataStorage.prefs!.getString(DataStorage.keyStudentId) ??
          DataStorage.defaultValueStudentId, // Student ID
      'xqdm': '1', // Semester term
    };
    final response = await http.get(
      Uri.https(baseUrl, '/admin/pkgl/xskb/sdpkkbList', queryParameters),
      headers: _getHeaders(),
    );

    if (await _checkResponse(response)) {
      return scheduleFromJson(response.body);
    } else {
      return getSchedule();
    }
  }

  static Future<bool> login(String username, String password) async {

    final response = await http.post(
      Uri.https(baseUrl, '/admin/login'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        "username": username,
        "password": password,
        "jcaptchaCode": "",
        "rememberMe": "1"
      },
    );

    if (response.statusCode == 302) {
      if (response.headers['set-cookie'] != null) {
        String rawCookies = response.headers['set-cookie']!;
        DataStorage.prefs!.setString(DataStorage.keyCookie, rawCookies);
      }
      return true;
    } else {
      return false;
    }
  }

  /// Check response validity.
  ///
  /// Returns true to indicate that the response is valid and we can continue to handle with the response.
  static Future<bool> _checkResponse(http.Response response) async {
    if (response.statusCode != 200) {
      final studentId = DataStorage.prefs!.getString(DataStorage.keyStudentId);
      final password = DataStorage.prefs!.getString(DataStorage.keyPassword);
      if (studentId != null && password != null) {
        await login(studentId, password);
      }
      return false;
    } else {
      return true;
    }
  }

  static Map<String, String>? _getHeaders() {
    Map<String, String>? headers;
    final cookies = DataStorage.prefs!.getString(DataStorage.keyCookie);
    if (cookies != null) {
      headers = {'Cookie': cookies};
    }
    return headers;
  }
}

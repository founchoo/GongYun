import 'dart:convert';

import 'package:gong_yun/api/data_storage_service.dart';
import 'package:gong_yun/model/grade_response.dart';
import 'package:gong_yun/model/ranking_info.dart';
import 'package:gong_yun/model/schedule.dart';
import 'package:gong_yun/model/student_info_response.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class NoRedirectClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.followRedirects = false;
    return _inner.send(request);
  }
}

class ChaoxingService {
  static const baseUrl = 'hbut.jw.chaoxing.com';

  static Future<void> getCalendar(String semesterYearAndNo) async {
    var client = NoRedirectClient();
    final response = await client.get(
        Uri.https(baseUrl, '/admin/system/zy/xlgl/getData/$semesterYearAndNo'));
    print(response.body);
  }

  static Future<List<Schedule>> getSchedule() async {
    var client = NoRedirectClient();
    final queryParameters = {
      'xnxq': '2023-2024-1', // Semester year and term
      'xhid': DataStorage.prefs!.getString(DataStorage.keyStudentId) ??
          DataStorage.defaultValueStudentId, // Student ID
      'xqdm': '1', // Semester term
    };
    final response = await client.get(
      Uri.https(baseUrl, '/admin/pkgl/xskb/sdpkkbList', queryParameters),
      headers: _getHeaders(),
    );

    if (await _checkResponse(response)) {
      return scheduleFromJson(response.body);
    } else {
      return getSchedule();
    }
  }

  static Future<List<Grade>> getGrade() async {
    var client = NoRedirectClient();
    final queryParameters = {
      'gridtype': "jqgrid",
      'queryFields': "id,xnxq,kcmc,xf,kcxz,ksxs,xdxz,zhcj,hdxf,",
      '_search': "false",
      'nd': DateTime.now().millisecondsSinceEpoch.toString(),
      'page.size': "500",
      'page.pn': "1",
      'sort': "id",
      'order': "asc",
      'startXnxq': "001",
      'endXnxq': "001",
      'sfjg': "",
      'query.startXnxq||': "001",
      'query.endXnxq||': "001",
      'query.sfjg||': "",
    };
    final response = await client.get(
      Uri.https(
          baseUrl, '/admin/xsd/xsdzgcjcx/xsdQueryXszgcjList', queryParameters),
      headers: _getHeaders(),
    );

    if (await _checkResponse(response)) {
      return gradeResponseFromJson(response.body).results;
    } else {
      return getGrade();
    }
  }

  static Future<RankingInfo> getRankingInfo(List<String> semesters) async {
    var client = NoRedirectClient();

    final queryParameters = {
      'sznj': DataStorage.prefs!.getString(DataStorage.keyEnrollYear) ??
          DataStorage.defaultValueEnrollYear, // Year of enrollment
      'xnxq': semesters.join(','), // Semester year and term, seperated by ','
    };
    final response = await client.get(
      Uri.https(baseUrl, '/admin/cjgl/xscjbbdy/getXscjpm', queryParameters),
      headers: _getHeaders(),
    );

    if (await _checkResponse(response)) {
      var rankingInfo = RankingInfo();
      final doc = parse(response.body);
      final elements = doc.querySelectorAll('table')[1].querySelectorAll('td');
      for (int i = 0; i < elements.length; i++) {
        final ele = elements[i];
        if (ele.text.contains('/')) {
          var parsedList = [0, 0];
          final list = ele.text.split('/');
          if (list.join().isEmpty) {
            parsedList[0] = 0;
            parsedList[1] = 0;
          } else {
            parsedList[0] = int.parse(list[0]);
            parsedList[1] = int.parse(list[1]);
          }
          if (i == 1) {
            rankingInfo.byGPAByInstitute = RankingItem(
              total: parsedList[1],
              rank: parsedList[0],
            );
          } else if (i == 2) {
            rankingInfo.byGPAByMajor = RankingItem(
              total: parsedList[1],
              rank: parsedList[0],
            );
          } else if (i == 3) {
            rankingInfo.byGPAByClass = RankingItem(
              total: parsedList[1],
              rank: parsedList[0],
            );
          } else if (i == 5) {
            rankingInfo.byScoreByInstitute = RankingItem(
              total: parsedList[1],
              rank: parsedList[0],
            );
          } else if (i == 6) {
            rankingInfo.byScoreByMajor = RankingItem(
              total: parsedList[1],
              rank: parsedList[0],
            );
          } else if (i == 7) {
            rankingInfo.byScoreByClass = RankingItem(
              total: parsedList[1],
              rank: parsedList[0],
            );
          }
        }
      }
      return rankingInfo;
    } else {
      return getRankingInfo(semesters);
    }
  }

  static Future<StudentInfo> getStudentInfo() async {
    var client = NoRedirectClient();
    final response = await client.get(
      Uri.https(baseUrl, '/admin/cjgl/xscjbbdy/printdgxscj'),
      headers: _getHeaders(),
    );

    if (await _checkResponse(response)) {
      return studentInfoResponseFromJson(response.body).data.records[0];
    } else {
      return getStudentInfo();
    }
  }

  static Future<bool> login(String username, String password) async {
    var client = NoRedirectClient();
    final response = await client.post(
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

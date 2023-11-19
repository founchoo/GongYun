// To parse this JSON data, do
//
//     final schedule = scheduleFromJson(jsonString);

import 'package:gong_yun/util/html_util.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'schedule.g.dart';

List<Schedule> scheduleFromJson(String str) => List<Schedule>.from(json.decode(str).map((x) => Schedule.fromJson(x)));

String scheduleToJson(List<Schedule> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Schedule {

  @JsonKey(name: "xnxq")
  String semesterYearAndNo;

  /// 课程类型
  @JsonKey(name: "type")
  int type;

  @JsonKey(name: "kcmc")
  String courseNameAsHtml;

  @JsonKey(name: "kcbh")
  String courseId;

  /// 周次，人类可读，例如：2-6
  @JsonKey(name: "zc")
  String weekNoHumanReadable;

  /// 周次，原始数据，例如：2,3,4,5,6
  @JsonKey(name: "zcstr")
  String weekNoRaw;

  @JsonKey(name: "croommc")
  String courseLocationAsHtml;

  @JsonKey(name: "tmc")
  String teacherNameAsHtml;

  /// 星期
  @JsonKey(name: "xingqi")
  int dayOfWeek;

  /// 节次
  @JsonKey(name: "djc")
  int node;

  /// 课程性质
  @JsonKey(name: "kcxz")
  String courseProperty;

  Schedule({
    required this.semesterYearAndNo,
    required this.type,
    required this.courseNameAsHtml,
    required this.courseId,
    required this.weekNoHumanReadable,
    required this.weekNoRaw,
    required this.courseLocationAsHtml,
    required this.teacherNameAsHtml,
    required this.dayOfWeek,
    required this.node,
    required this.courseProperty,
  });

  String? get courseLocation {
    return HtmlUtil.getInnerText(courseLocationAsHtml);
  }

  String? get courseName {
    return HtmlUtil.getInnerText(courseNameAsHtml);
  }

  List<int> get weekNoMachineReadable {
    return weekNoRaw.split(',').map((e) => int.parse(e)).toList();
  }

  bool isCurrentWeekCourse(int currentWeekNo) {
    return weekNoMachineReadable.contains(currentWeekNo);
  }

  double getOpacity(int currentWeekNo) {
    if (isCurrentWeekCourse(currentWeekNo)) {
      return 1.0;
    } else {
      return 0.3;
    }
  }

  factory Schedule.fromJson(Map<String, dynamic> json) => _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}

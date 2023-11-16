// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      semesterYearAndNo: json['xnxq'] as String,
      type: json['type'] as int,
      courseNameAsHtml: json['kcmc'] as String,
      courseId: json['kcbh'] as String,
      weekNoHumanReadable: json['zc'] as String,
      weekNoRaw: json['zcstr'] as String,
      courseLocationAsHtml: json['croommc'] as String,
      teacherNameAsHtml: json['tmc'] as String,
      dayOfWeek: json['xingqi'] as int,
      node: json['djc'] as int,
      courseProperty: json['kcxz'] as String,
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'xnxq': instance.semesterYearAndNo,
      'type': instance.type,
      'kcmc': instance.courseNameAsHtml,
      'kcbh': instance.courseId,
      'zc': instance.weekNoHumanReadable,
      'zcstr': instance.weekNoRaw,
      'croommc': instance.courseLocationAsHtml,
      'tmc': instance.teacherNameAsHtml,
      'xingqi': instance.dayOfWeek,
      'djc': instance.node,
      'kcxz': instance.courseProperty,
    };

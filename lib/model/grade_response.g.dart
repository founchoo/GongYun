// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GradeResponse _$GradeResponseFromJson(Map<String, dynamic> json) =>
    GradeResponse(
      msg: json['msg'] as String,
      ret: json['ret'] as int,
      page: json['page'] as int,
      rows: json['rows'] as int,
      total: json['total'] as int,
      totalPages: json['totalPages'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => Grade.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GradeResponseToJson(GradeResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'ret': instance.ret,
      'page': instance.page,
      'rows': instance.rows,
      'total': instance.total,
      'totalPages': instance.totalPages,
      'results': instance.results,
    };

Grade _$GradeFromJson(Map<String, dynamic> json) => Grade(
      semesterYearAndNo: json['xnxq'] as String,
      credit: json['xf'] as String,
      courseName: json['kcmc'] as String,
      courseProperty: json['kcxz'] as String,
      detail: json['cjfxms'] as String?,
      score: json['zhcj'] as String,
      creditGain: (json['hdxf'] as num).toDouble(),
      gradePoint: (json['jd'] as num).toDouble(),
      courseId: json['kcid'] as String,
    );

Map<String, dynamic> _$GradeToJson(Grade instance) => <String, dynamic>{
      'xnxq': instance.semesterYearAndNo,
      'xf': instance.credit,
      'kcmc': instance.courseName,
      'kcxz': instance.courseProperty,
      'cjfxms': instance.detail,
      'zhcj': instance.score,
      'hdxf': instance.creditGain,
      'jd': instance.gradePoint,
      'kcid': instance.courseId,
    };

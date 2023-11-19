// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentInfoResponse _$StudentInfoResponseFromJson(Map<String, dynamic> json) =>
    StudentInfoResponse(
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StudentInfoResponseToJson(
        StudentInfoResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      records: (json['records'] as List<dynamic>)
          .map((e) => StudentInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'records': instance.records,
    };

StudentInfo _$StudentInfoFromJson(Map<String, dynamic> json) => StudentInfo(
      currentUserId: json['currentUserId'] as String,
      userRoleId: json['userRoleId'] as String,
      dataAuth: json['dataAuth'] as bool,
      dataXnxq: json['dataXnxq'] as String,
      currentRoleId: json['currentRoleId'] as String,
      currentJsId: json['currentJsId'] as String,
      currentUserName: json['currentUserName'] as String,
      currentDepartmentId: json['currentDepartmentId'] as String,
      id: json['id'] as String,
      xh: json['xh'] as String,
      xm: json['xm'] as String,
      xmpy: json['xmpy'] as String,
      xbdm: json['xbdm'] as String,
      zzmmdm: json['zzmmdm'] as String,
      zjlxdm: json['zjlxdm'] as String,
      sfzjh: json['sfzjh'] as String,
      csrq: DateTime.parse(json['csrq'] as String),
      mzdm: json['mzdm'] as String,
      jtzz: json['jtzz'] as String,
      ksh: json['ksh'] as String,
      createBy: AteBy.fromJson(json['createBy'] as Map<String, dynamic>),
      createDate: DateTime.parse(json['createDate'] as String),
      updateBy: AteBy.fromJson(json['updateBy'] as Map<String, dynamic>),
      updateDate: DateTime.parse(json['updateDate'] as String),
      status: json['status'] as String,
      gkzp: json['gkzp'] as String,
      yxdm: json['yxdm'] as String,
      zydm: json['zydm'] as String,
      sznj: json['sznj'] as String,
      rxnj: json['rxnj'] as String,
      bjdm: json['bjdm'] as String,
      xslbdm: json['xslbdm'] as String,
      pyccdm: json['pyccdm'] as String,
      xjzt: json['xjzt'] as String,
      xsdqztdm: json['xsdqztdm'] as String,
      rxnf: DateTime.parse(json['rxnf'] as String),
      xz: json['xz'] as String,
      sfzx: json['sfzx'] as String,
      zymc: json['zymc'] as String,
      bjmc: json['bjmc'] as String,
      yxmc: json['yxmc'] as String,
      xxzydm: json['xxzydm'] as String,
      wfwtbzt: json['wfwtbzt'] as String,
      recordNew: json['new'] as bool,
    );

Map<String, dynamic> _$StudentInfoToJson(StudentInfo instance) =>
    <String, dynamic>{
      'currentUserId': instance.currentUserId,
      'userRoleId': instance.userRoleId,
      'dataAuth': instance.dataAuth,
      'dataXnxq': instance.dataXnxq,
      'currentRoleId': instance.currentRoleId,
      'currentJsId': instance.currentJsId,
      'currentUserName': instance.currentUserName,
      'currentDepartmentId': instance.currentDepartmentId,
      'id': instance.id,
      'xh': instance.xh,
      'xm': instance.xm,
      'xmpy': instance.xmpy,
      'xbdm': instance.xbdm,
      'zzmmdm': instance.zzmmdm,
      'zjlxdm': instance.zjlxdm,
      'sfzjh': instance.sfzjh,
      'csrq': instance.csrq.toIso8601String(),
      'mzdm': instance.mzdm,
      'jtzz': instance.jtzz,
      'ksh': instance.ksh,
      'createBy': instance.createBy,
      'createDate': instance.createDate.toIso8601String(),
      'updateBy': instance.updateBy,
      'updateDate': instance.updateDate.toIso8601String(),
      'status': instance.status,
      'gkzp': instance.gkzp,
      'yxdm': instance.yxdm,
      'zydm': instance.zydm,
      'sznj': instance.sznj,
      'rxnj': instance.rxnj,
      'bjdm': instance.bjdm,
      'xslbdm': instance.xslbdm,
      'pyccdm': instance.pyccdm,
      'xjzt': instance.xjzt,
      'xsdqztdm': instance.xsdqztdm,
      'rxnf': instance.rxnf.toIso8601String(),
      'xz': instance.xz,
      'sfzx': instance.sfzx,
      'zymc': instance.zymc,
      'bjmc': instance.bjmc,
      'yxmc': instance.yxmc,
      'xxzydm': instance.xxzydm,
      'wfwtbzt': instance.wfwtbzt,
      'new': instance.recordNew,
    };

AteBy _$AteByFromJson(Map<String, dynamic> json) => AteBy(
      currentUserId: json['currentUserId'] as String,
      userRoleId: json['userRoleId'] as String,
      dataAuth: json['dataAuth'] as bool,
      dataXnxq: json['dataXnxq'] as String,
      currentRoleId: json['currentRoleId'] as String,
      currentJsId: json['currentJsId'] as String,
      currentUserName: json['currentUserName'] as String,
      currentDepartmentId: json['currentDepartmentId'] as String,
      id: json['id'] as String,
      status: json['status'] as String,
      credentialsSalt: json['credentialsSalt'] as String,
      ateByNew: json['new'] as bool,
    );

Map<String, dynamic> _$AteByToJson(AteBy instance) => <String, dynamic>{
      'currentUserId': instance.currentUserId,
      'userRoleId': instance.userRoleId,
      'dataAuth': instance.dataAuth,
      'dataXnxq': instance.dataXnxq,
      'currentRoleId': instance.currentRoleId,
      'currentJsId': instance.currentJsId,
      'currentUserName': instance.currentUserName,
      'currentDepartmentId': instance.currentDepartmentId,
      'id': instance.id,
      'status': instance.status,
      'credentialsSalt': instance.credentialsSalt,
      'new': instance.ateByNew,
    };
